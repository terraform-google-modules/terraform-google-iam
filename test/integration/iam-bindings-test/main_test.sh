#!/bin/bash
# Copyright 2018 Google LLC
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


#################################################################
#   PLEASE FILL THE VARIABLES WITH VALID VALUES FOR TESTING     #
#   DO NOT REMOVE/ADD ANY OF THE VARIABLES                      #
#################################################################

#################################################################
#   RESOURCE IDENTIFIERS, VARIABLES AND ROLES                   #
#################################################################

# Projects
export PROJECT_ID_1="base-project-196723"
export PROJECT_ID_2="lnesci-xpn-host"

# Organizations
export ORGANIZATION_ID="65779779009"

# Folders
export FOLDER_ID_1="886025180534"
export FOLDER_ID_2="560109990580"

# Subnets
export SUBNET_1="projects/base-project-196723/regions/us-central1/subnetworks/default"
export SUBNET_2="projects/base-project-196723/regions/us-east1/subnetworks/default"

# Service accounts
export SERVICE_ACCOUNT_1="terraform5@base-project-196723.iam.gserviceaccount.com"
export SERVICE_ACCOUNT_2="terraform6@base-project-196723.iam.gserviceaccount.com"

# Storage buckets
export STORAGE_BUCKET_1="usage-report-bucket-pf-test-200318"
export STORAGE_BUCKET_2="usage-report-bucket-pf-test-200318-2"

# Kms crypto keys
export KMS_CRYPTO_KEY_1="projects/base-project-196723/locations/us-central1/keyRings/ring1/cryptoKeys/key1"
export KMS_CRYPTO_KEY_2="projects/base-project-196723/locations/global/keyRings/ring2/cryptoKeys/key2"

# Kms key rings
export KMS_KEY_RING_1="projects/base-project-196723/locations/us-central1/keyRings/ring1"
export KMS_KEY_RING_2="projects/base-project-196723/locations/global/keyRings/ring2"

# Pubsub subscriptions
export PUBSUB_SUBSCRIPTION_1="subscription1"
export PUBSUB_SUBSCRIPTION_2="subscription2"

# Pubsub topics
export PUBSUB_TOPIC_1="topic1"
export PUBSUB_TOPIC_2="topic2"

# Roles for project
export PROJECT_ROLE_1="roles/iam.securityReviewer"
export PROJECT_ROLE_2="roles/iam.roleViewer"

# Roles for organization
export ORGANIZATION_ROLE_1="roles/owner"
export ORGANIZATION_ROLE_2="roles/iam.organizationRoleViewer"

# Roles for folder
export FOLDER_ROLE_1="roles/owner"
export FOLDER_ROLE_2="roles/editor"

# Roles for subnet
export SUBNET_ROLE_1="roles/owner"
export SUBNET_ROLE_2="roles/editor"

# Roles for service account
export SERVICE_ACCOUNT_ROLE_1="roles/owner"
export SERVICE_ACCOUNT_ROLE_2="roles/editor"

# Roles for storage bucket
export STORAGE_BUCKET_ROLE_1="roles/storage.legacyObjectReader"
export STORAGE_BUCKET_ROLE_2="roles/storage.legacyBucketReader"

# Roles for kms crypto key
export KMS_CRYPTO_KEY_ROLE_1="roles/owner"
export KMS_CRYPTO_KEY_ROLE_2="roles/editor"

# Roles for kms key ring
export KMS_KEY_RING_ROLE_1="roles/owner"
export KMS_KEY_RING_ROLE_2="roles/editor"

# Roles for pubsub subscription
export PUBSUB_SUBSCRIPTION_ROLE_1="roles/owner"
export PUBSUB_SUBSCRIPTION_ROLE_2="roles/editor"

# Roles for pubsub topic
export PUBSUB_TOPIC_ROLE_1="roles/owner"
export PUBSUB_TOPIC_ROLE_2="roles/editor"

# Members
export MEMBER_1="user:lucas@lnescidev.com"
export MEMBER_2="user:angelzamir@google.com"

# Credentials
export CREDENTIALS_PATH="/vagrant/terraform5.json"
export CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE=$CREDENTIALS_PATH

#################################################################
#   HELPER FUNCTION FOR VARIABLE RETRIEVAL                      #
#################################################################
function get_sub_string_split(){
  STRING="$1"
  SEPARATOR="$2"
  PART=$3
  IFS="$SEPARATOR" read -ra SPLIT <<< $STRING
  echo "${SPLIT[$PART]}"
}

#################################################################
#   COMPLEMENTARY VALUES FOR SOME RESOURCES                     #
#################################################################

# Subnets
export SUBNET_1_PROJECT=$(get_sub_string_split "$SUBNET_1" "/" 1)
export SUBNET_1_REGION=$(get_sub_string_split "$SUBNET_1" "/" 3)
export SUBNET_1_NAME=$(get_sub_string_split "$SUBNET_1" "/" 5)

export SUBNET_2_PROJECT=$(get_sub_string_split "$SUBNET_2" "/" 1)
export SUBNET_2_REGION=$(get_sub_string_split "$SUBNET_2" "/" 3)
export SUBNET_2_NAME=$(get_sub_string_split "$SUBNET_2" "/" 5)

# Kms key rings
export KMS_KEY_RING_1_PROJECT=$(get_sub_string_split "$KMS_KEY_RING_1" "/" 1)
export KMS_KEY_RING_1_LOCATION=$(get_sub_string_split "$KMS_KEY_RING_1" "/" 3)
export KMS_KEY_RING_1_NAME=$(get_sub_string_split "$KMS_KEY_RING_1" "/" 5)

export KMS_KEY_RING_2_PROJECT=$(get_sub_string_split "$KMS_KEY_RING_2" "/" 1)
export KMS_KEY_RING_2_LOCATION=$(get_sub_string_split "$KMS_KEY_RING_2" "/" 3)
export KMS_KEY_RING_2_NAME=$(get_sub_string_split "$KMS_KEY_RING_2" "/" 5)

# Kms crypto keys
export KMS_CRYPTO_KEY_1_PROJECT=$(get_sub_string_split "$KMS_CRYPTO_KEY_1" "/" 1)
export KMS_CRYPTO_KEY_1_LOCATION=$(get_sub_string_split "$KMS_CRYPTO_KEY_1" "/" 3)
export KMS_CRYPTO_KEY_1_RING=$(get_sub_string_split "$KMS_CRYPTO_KEY_1" "/" 5)
export KMS_CRYPTO_KEY_1_NAME=$(get_sub_string_split "$KMS_CRYPTO_KEY_1" "/" 7)

export KMS_CRYPTO_KEY_2_PROJECT=$(get_sub_string_split "$KMS_CRYPTO_KEY_2" "/" 1)
export KMS_CRYPTO_KEY_2_LOCATION=$(get_sub_string_split "$KMS_CRYPTO_KEY_2" "/" 3)
export KMS_CRYPTO_KEY_2_RING=$(get_sub_string_split "$KMS_CRYPTO_KEY_2" "/" 5)
export KMS_CRYPTO_KEY_2_NAME=$(get_sub_string_split "$KMS_CRYPTO_KEY_2" "/" 7)

#################################################################
#   FUNCTIONS FOR PREPARING WORKSPACE AND CALLING BATS          #
#################################################################

# Cleans the workdir
function clean_workdir() {
  echo "Cleaning workdir"
  yes | rm -f terraform.tfstate*
  yes | rm -f *.tf
  yes | rm -rf .terraform
}

# Creates the main.tf file for Terraform
function create_main_tf_file() {
  echo "Creating main.tf file"
  touch main.tf
  cat <<EOF > main.tf
locals {
  credentials_file_path    = "$CREDENTIALS_PATH"
}

provider "google" {
  credentials              = "\${file(local.credentials_file_path)}"
}

module "iam_binding_project" {
  source              = "../../"
  mode                = "$MODE"
  projects            = ["$PROJECT_ID_1", "$PROJECT_ID_2"]

  bindings = {
    "$PROJECT_ROLE_1" = [
      "$MEMBER_1",
      "$MEMBER_2",
    ]

    "$PROJECT_ROLE_2" = [
      "$MEMBER_1"
    ]
  }
}

module "iam_binding_organization" {
  source              = "../../"
  mode                = "$MODE"
  organizations             = ["$ORGANIZATION_ID"]

  bindings = {
    "$ORGANIZATION_ROLE_1" = [
      "$MEMBER_1",
      "$MEMBER_2",
    ]

    "$ORGANIZATION_ROLE_2" = [
      "$MEMBER_1"
    ]
  }
}

module "iam_binding_folder" {
  source              = "../../"
  mode                = "$MODE"
  folders             = ["$FOLDER_ID_1", "$FOLDER_ID_2"]

  bindings = {
    "$FOLDER_ROLE_1" = [
      "$MEMBER_1",
      "$MEMBER_2",
    ]

    "$FOLDER_ROLE_2" = [
      "$MEMBER_1"
    ]
  }
}

module "iam_binding_subnet" {
  source               = "../../"
  mode                 = "$MODE"
  subnets              = ["$SUBNET_1", "$SUBNET_2"]

  bindings = {
    "$SUBNET_ROLE_1" = [
      "$MEMBER_1",
      "$MEMBER_2",
    ]

    "$SUBNET_ROLE_2" = [
      "$MEMBER_1"
    ]
  }
}

module "iam_binding_service_account" {
  source               = "../../"
  mode                 = "$MODE"
  service_accounts     = ["$SERVICE_ACCOUNT_1", "$SERVICE_ACCOUNT_2"]
  project              = "$PROJECT_ID_1"

  bindings = {
    "$SERVICE_ACCOUNT_ROLE_1" = [
      "$MEMBER_1",
      "$MEMBER_2",
    ]

    "$SERVICE_ACCOUNT_ROLE_2" = [
      "$MEMBER_1"
    ]
  }
}

module "iam_binding_storage_bucket" {
  source               = "../../"
  mode                 = "$MODE"
  storage_buckets      = ["$STORAGE_BUCKET_1", "$STORAGE_BUCKET_2"]

  bindings = {
    "$STORAGE_BUCKET_ROLE_1" = [
      "$MEMBER_1",
      "$MEMBER_2",
    ]

    "$STORAGE_BUCKET_ROLE_2" = [
      "$MEMBER_1"
    ]
  }
}

module "iam_binding_kms_crypto_key" {
  source               = "../../"
  mode                 = "$MODE"
  kms_crypto_keys      = ["$KMS_CRYPTO_KEY_1", "$KMS_CRYPTO_KEY_2"]

  bindings = {
    "$KMS_CRYPTO_KEY_ROLE_1" = [
      "$MEMBER_1",
      "$MEMBER_2",
    ]

    "$KMS_CRYPTO_KEY_ROLE_2" = [
      "$MEMBER_1"
    ]
  }
}

module "iam_binding_kms_key_ring" {
  source               = "../../"
  mode                 = "$MODE"
  kms_key_rings        = ["$KMS_KEY_RING_1", "$KMS_CRYPTO_KEY_2"]

  bindings = {
    "$KMS_KEY_RING_ROLE_1" = [
      "$MEMBER_1",
      "$MEMBER_2",
    ]

    "$KMS_KEY_RING_ROLE_2" = [
      "$MEMBER_1"
    ]
  }
}

module "iam_binding_pubsub_subscription" {
  source               = "../../"
  mode                 = "$MODE"
  pubsub_subscriptions = ["$PUBSUB_SUBSCRIPTION_1", "$PUBSUB_SUBSCRIPTION_2"]
  project              = "$PROJECT_ID_1"

  bindings = {
    "$PUBSUB_SUBSCRIPTION_ROLE_1" = [
      "$MEMBER_1",
      "$MEMBER_2",
    ]

    "$PUBSUB_SUBSCRIPTION_ROLE_2" = [
      "$MEMBER_1"
    ]
  }
}

module "iam_binding_pubsub_topic" {
  source               = "../../"
  mode                 = "$MODE"
  pubsub_topics        = ["$PUBSUB_TOPIC_1", "$PUBSUB_TOPIC_2"]
  project              = "$PROJECT_ID_1"

  bindings = {
    "$PUBSUB_TOPIC_ROLE_1" = [
      "$MEMBER_1",
      "$MEMBER_2",
    ]

    "$PUBSUB_TOPIC_ROLE_2" = [
      "$MEMBER_1"
    ]
  }
}
EOF
}

#################################################################
#   WORKSPACE CLEANING, BATS CALLING                            #
#################################################################

# Preparing environment
clean_workdir
create_main_tf_file

# Call to bats
echo "Test to execute: $(bats iam-bindings-test/integration.bats -c)"
bats iam-bindings-test/integration.bats

export CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE=""
unset CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE

# Clean the environment
clean_workdir
echo "Integration test finished"