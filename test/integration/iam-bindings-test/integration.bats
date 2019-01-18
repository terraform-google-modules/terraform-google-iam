#!/usr/bin/env bats

load helpers

# #################################### #
#             Terraform tests          #
# #################################### #

@test "Ensure that Terraform configures the dirs and download the plugins" {

  run terraform init
  [ "$status" -eq 0 ]
}

@test "Ensure that Terraform updates the plugins" {

  run terraform get
  [ "$status" -eq 0 ]
}

@test "Terraform plan, ensure connection and creation of IAM binding resources" {

  run terraform plan
  [ "$status" -eq 0 ]
  [[ "$output" =~ $RESOURCE_NUMBER\ to\ add ]]
  [[ "$output" =~ 0\ to\ change ]]
  [[ "$output" =~ 0\ to\ destroy ]]
}

@test "Terraform apply" {

  run terraform apply -auto-approve
  [ "$status" -eq 0 ]
  [[ "$output" =~ $RESOURCE_NUMBER\ added ]]
  [[ "$output" =~ 0\ changed ]]
  [[ "$output" =~ 0\ destroyed ]]
}

# #################################### #
#             gcloud tests             #
# #################################### #

@test "Test bindings on projects $PROJECT_ID_1, $PROJECT_ID_2" {

  BINDINGS=$(gcloud projects get-iam-policy $PROJECT_ID_1 --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$PROJECT_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$PROJECT_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]

  BINDINGS=$(gcloud projects get-iam-policy $PROJECT_ID_2 --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$PROJECT_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$PROJECT_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]
}

@test "Test bindings on organization $ORGANIZATION_ID" {

  BINDINGS=$(gcloud organizations get-iam-policy $ORGANIZATION_ID --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$ORGANIZATION_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$ORGANIZATION_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]
}

@test "Test bindings on folders $FOLDER_ID_1, $FOLDER_ID_2" {

  BINDINGS=$(gcloud beta resource-manager folders get-iam-policy $FOLDER_ID_1 --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$FOLDER_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$FOLDER_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]

  BINDINGS=$(gcloud beta resource-manager folders get-iam-policy $FOLDER_ID_2 --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$FOLDER_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$FOLDER_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]
}

@test "Test bindings on service accounts $SERVICE_ACCOUNT_1, $SERVICE_ACCOUNT_2" {

  BINDINGS=$(gcloud iam service-accounts get-iam-policy $SERVICE_ACCOUNT_1 --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$SERVICE_ACCOUNT_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$SERVICE_ACCOUNT_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]

  BINDINGS=$(gcloud iam service-accounts get-iam-policy $SERVICE_ACCOUNT_2 --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$SERVICE_ACCOUNT_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$SERVICE_ACCOUNT_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]
}

@test "Test bindings on subnetworks $SUBNET_1, $SUBNET_2" {

  BINDINGS=$(gcloud beta compute networks subnets get-iam-policy $SUBNET_1_NAME --project="$SUBNET_1_PROJECT" --region="$SUBNET_1_REGION" --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$SUBNET_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$SUBNET_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]

  BINDINGS=$(gcloud beta compute networks subnets get-iam-policy $SUBNET_2_NAME --project="$SUBNET_2_PROJECT" --region="$SUBNET_2_REGION" --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$SUBNET_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$SUBNET_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]
}

@test "Test bindings on kms key rings $KMS_KEY_RING_1, $KMS_KEY_RING2" {

  BINDINGS=$(gcloud kms keyrings get-iam-policy $KMS_KEY_RING_1_NAME --project="$KMS_KEY_RING_1_PROJECT" --location="$KMS_KEY_RING_1_LOCATION" --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$KMS_KEY_RING_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$KMS_KEY_RING_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]

  BINDINGS=$(gcloud kms keyrings get-iam-policy $KMS_KEY_RING_2_NAME --project="$KMS_KEY_RING_2_PROJECT" --location="$KMS_KEY_RING_2_LOCATION" --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$KMS_KEY_RING_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$KMS_KEY_RING_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]
}

@test "Test bindings on kms crypto keys $KMS_CRYPTO_KEY_1, $KMS_CRYPTO_KEY_2" {

  BINDINGS=$(gcloud kms keys get-iam-policy $KMS_CRYPTO_KEY_1_NAME --project="$KMS_CRYPTO_KEY_1_PROJECT" --location="$KMS_CRYPTO_KEY_1_LOCATION" --keyring="$KMS_CRYPTO_KEY_1_RING" --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$KMS_CRYPTO_KEY_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$KMS_CRYPTO_KEY_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]

  BINDINGS=$(gcloud kms keys get-iam-policy $KMS_CRYPTO_KEY_2_NAME --project="$KMS_CRYPTO_KEY_2_PROJECT" --location="$KMS_CRYPTO_KEY_2_LOCATION" --keyring="$KMS_CRYPTO_KEY_2_RING" --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$KMS_CRYPTO_KEY_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$KMS_CRYPTO_KEY_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]
}

@test "Test bindings on pubsub topics $PUBSUB_TOPIC_1, $PUBSUB_TOPIC_2" {

  BINDINGS=$(gcloud beta pubsub topics get-iam-policy $PUBSUB_TOPIC_1 --project="$PROJECT_ID_1" --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$PUBSUB_TOPIC_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$PUBSUB_TOPIC_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]

  BINDINGS=$(gcloud beta pubsub topics get-iam-policy $PUBSUB_TOPIC_2 --project="$PROJECT_ID_1" --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$PUBSUB_TOPIC_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$PUBSUB_TOPIC_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]
}

@test "Test bindings on pubsub subscriptions $PUBSUB_SUBSCRIPTION_1, $PUBSUB_SUBSCRIPTION_2" {

  BINDINGS=$(gcloud beta pubsub subscriptions get-iam-policy $PUBSUB_SUBSCRIPTION_1 --project="$PROJECT_ID_1" --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$PUBSUB_SUBSCRIPTION_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$PUBSUB_SUBSCRIPTION_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]

  BINDINGS=$(gcloud beta pubsub subscriptions get-iam-policy $PUBSUB_SUBSCRIPTION_2 --project="$PROJECT_ID_1" --format="json(bindings)")
  MEMBERS=$(get_members_from_binding "$BINDINGS" "$PUBSUB_SUBSCRIPTION_ROLE_1")
  run echo "$MEMBERS"
  [ "$status" -eq 0 ]
  [[ "$output" = *"$MEMBER_1"* ]]
  [[ "$output" = *"$MEMBER_2"* ]]

  MEMBERS=$(get_members_from_binding "$BINDINGS" "$PUBSUB_SUBSCRIPTION_ROLE_2")
  run echo "$MEMBERS"
  [[ "$output" = *"$MEMBER_1"* ]]
}

# #################################### #
#      Terraform destroy test          #
# #################################### #

@test "Terraform destroy" {

  run terraform destroy -force
  [ "$status" -eq 0 ]
  [[ "$output" =~ $RESOURCE_NUMBER\ destroyed ]]
}

