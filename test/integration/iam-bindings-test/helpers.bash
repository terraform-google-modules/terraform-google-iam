#!/bin/bash

# #################################### #
#     Helper functions for bats        #
# #################################### #

# Given a json with gcloud iam policy bindings, return the members for the specified role
function get_members_from_binding(){
  BINDINGS="$1"
  ROLE="$2"
  RESULT=$(echo "$BINDINGS" | jq -r --arg role "$ROLE" '.bindings[] | select(.role==$role) | .members[]')
  echo "$RESULT"
}