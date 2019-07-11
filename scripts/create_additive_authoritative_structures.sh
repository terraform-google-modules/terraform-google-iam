#!/bin/bash
# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


MODE="$1"
BINDINGS_STR="$2"
OBJECTS_STR="$3"
PROJECT="$4"
SERVICE_ACCOUNT="$5"
KEY_RING="$6"
CRYPTO_KEY="$7"
OBJECTS=""
OUTPUT=""

# Convert the string variables to proper bash variables
function prepare_structures {
  OBJECTS=$(echo "$OBJECTS_STR" | jq -r '.[]?')
}

# Helper function for string splitting
function get_sub_string_split {
  STRING="$1"
  SEPARATOR="$2"
  PART=$3
  IFS="$SEPARATOR" read -ra SPLIT <<< "$STRING"
  echo "${SPLIT[$PART]}"
}

# Formats a service account
function format_service_account {
  SERVICE_ACCOUNT="$1"
  SERVICE_ACCOUNT_FMT=$(printf "projects/%s/serviceAccounts/%s" "$PROJECT" "$SERVICE_ACCOUNT")
  echo -e "$SERVICE_ACCOUNT_FMT"
}

# Formats a key ring
function format_key_ring {
  KEY_RING="$1"
  KEY_RING_PROJECT=$(get_sub_string_split "$KEY_RING" "/" 1)
  KEY_RING_LOCATION=$(get_sub_string_split "$KEY_RING" "/" 3)
  KEY_RING_NAME=$(get_sub_string_split "$KEY_RING" "/" 5)
  KEY_RING_FMT=$(printf "%s/%s/%s" "$KEY_RING_PROJECT" "$KEY_RING_LOCATION" "$KEY_RING_NAME")
  echo -e "$KEY_RING_FMT"
}

# Formats a crypto key
function format_crypto_key {
  CRYPTO_KEY="$1"
  CRYPTO_KEY_PROJECT=$(get_sub_string_split "$CRYPTO_KEY" "/" 1)
  CRYPTO_KEY_LOCATION=$(get_sub_string_split "$CRYPTO_KEY" "/" 3)
  CRYPTO_KEY_RING=$(get_sub_string_split "$CRYPTO_KEY" "/" 5)
  CRYPTO_KEY_NAME=$(get_sub_string_split "$CRYPTO_KEY" "/" 7)
  CRYPTO_KEY_FMT=$(printf "%s/%s/%s/%s" "$CRYPTO_KEY_PROJECT" "$CRYPTO_KEY_LOCATION" "$CRYPTO_KEY_RING" "$CRYPTO_KEY_NAME")
  echo -e "$CRYPTO_KEY_FMT"
}

# Takes and "object" (e.g. subnet) and formats it depending on its type
function format_object {
  OBJECT="$1"

  if [[ "$SERVICE_ACCOUNT" = "1" ]]
  then
    OBJECT=$(format_service_account "$OBJECT")
  elif [[ "$KEY_RING" = "1" ]]
  then
    OBJECT=$(format_key_ring "$OBJECT")
  elif [[ "$CRYPTO_KEY" = "1" ]]
  then
    OBJECT=$(format_crypto_key "$OBJECT")
  fi

  echo -e "$OBJECT"
}

# Builds an additive structure
# It's the cartesian product between the roles, members and objects
function build_additive {
  IFS=$'\n' read -r -d ' ' -a OBJECTS_ARRAY <<< "$OBJECTS"

  ROLES=$(echo "$BINDINGS_STR" | jq -r 'keys[]')
  IFS=$'\n' read -r -d ' ' -a ROLES_ARRAY <<< "$ROLES"

  for ROLE in "${ROLES_ARRAY[@]}"
  do
    MEMBERS=$(echo "$BINDINGS_STR" | jq -r --arg role "$ROLE" 'to_entries[] | select(.key==$role) | .value[]?')
    IFS=$'\n' read -r -d ' ' -a MEMBERS_ARRAY <<< "$MEMBERS"

    for MEMBER in "${MEMBERS_ARRAY[@]}"
    do

      for OBJECT in "${OBJECTS_ARRAY[@]}"
      do
        OBJECT=$(format_object "$OBJECT")
        OUTPUT=$(printf "%s %s %s,%s" "$OBJECT" "$MEMBER" "$ROLE" "$OUTPUT")
      done

    done

  done
}

# Builds an authoritative structure
function build_authoritative {
  IFS=$'\n' read -r -d ' ' -a OBJECTS_ARRAY <<< "$OBJECTS"

  ROLES=$(echo "$BINDINGS_STR" | jq -r 'keys[]')
  IFS=$'\n' read -r -d ' ' -a ROLES_ARRAY <<< "$ROLES"

  for ROLE in "${ROLES_ARRAY[@]}"
  do

    MEMBERS=$(echo "$BINDINGS_STR" | jq -r --arg role "$ROLE" 'to_entries[] | select(.key==$role) | .value[]?')
    IFS=$'\n' read -r -d ' ' -a MEMBERS_ARRAY <<< "$MEMBERS"
    MEMBERS_FMT=""
    for MEMBER in "${MEMBERS_ARRAY[@]}"
    do
      MEMBERS_FMT=$(printf "%s %s" "$MEMBER" "$MEMBERS_FMT")
    done

    for OBJECT in "${OBJECTS_ARRAY[@]}"
    do
      OBJECT=$(format_object "$OBJECT")
      OUTPUT=$(printf "%s %s =%s,%s" "$OBJECT" "$ROLE" "$MEMBERS_FMT" "$OUTPUT")
    done

  done
}

# Main function
function main {
  # Convert the variables to proper types
  prepare_structures

  if [[ "$MODE" = "additive" ]]
  then
    build_additive
  elif [[ "$MODE" = "authoritative" ]]
  then
    build_authoritative
  fi

  jq -n --arg output "$OUTPUT" '{data:$output}'
}

main
