/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  n        = 2
  prefix   = "test-iam"
  location = "us-central1"
}

# Folders

resource "google_folder" "test" {
  count = local.n

  display_name = "Test IAM Folder ${count.index}"
  parent       = "organizations/${var.org_id}"
}

# Projects

resource "random_id" "test" {
  count = local.n

  byte_length = 2
}

resource "google_project" "test" {
  count = local.n

  project_id      = "${local.prefix}-prj-${count.index}-${random_id.test[count.index].hex}"
  org_id          = var.org_id
  billing_account = var.billing_account

  name = "Test IAM Project ${count.index}"
}

# Service Accounts

resource "google_service_account" "test" {
  count = local.n

  project = google_project.test[0].project_id

  account_id = "${local.prefix}-svcacct-${count.index}-${random_id.test[count.index].hex}"
}

# Buckets

resource "google_storage_bucket" "test" {
  count = local.n

  project = google_project.test[0].project_id

  name = "${local.prefix}-bkt-${count.index}-${random_id.test[count.index].hex}"
}

# KMS

resource "google_project_service" "kms" {
  count = local.n

  project = google_project.test[count.index].project_id
  service = "cloudkms.googleapis.com"
}

resource "google_kms_key_ring" "test" {
  count = local.n

  depends_on = [google_project_service.kms]

  project = google_project.test[0].project_id

  name     = "${local.prefix}-keyrng-${count.index}-${random_id.test[count.index].hex}"
  location = local.location
}

resource "google_kms_crypto_key" "test" {
  count = local.n

  name = "${local.prefix}-key-${count.index}-${random_id.test[count.index].hex}"

  key_ring = google_kms_key_ring.test[count.index].self_link
}

# Pubsub

resource "google_pubsub_topic" "test" {
  count = local.n

  project = google_project.test[0].project_id

  name = "${local.prefix}-tpc-${count.index}-${random_id.test[count.index].hex}"
}

resource "google_pubsub_subscription" "test" {
  count = local.n

  project = google_project.test[0].project_id

  topic = google_pubsub_topic.test[count.index].name
  name  = "${local.prefix}-sub-${count.index}-${random_id.test[count.index].hex}"
}

# Members

resource "google_service_account" "member" {
  count = local.n

  project = google_project.test[count.index].project_id

  account_id = "${local.prefix}-member-${count.index}-${random_id.test[count.index].hex}"
}

