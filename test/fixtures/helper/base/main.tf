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
  n           = 1
  prefix      = "test-iam"
  location    = var.base_location
  subnet_cidr = var.subnet_cidr
}

# Folders

resource "google_folder" "test" {
  count = local.n

  display_name = "${local.prefix}-folder-${count.index}-${random_id.test[count.index].hex}"
  parent       = var.base_parent_id
}

# Projects

resource "random_id" "test" {
  count = local.n

  byte_length = 4
}

resource "google_project" "test" {
  count = local.n

  project_id      = "${local.prefix}-prj-${count.index}-${random_id.test[count.index].hex}"
  folder_id       = var.base_parent_id
  name            = "Test IAM Project ${count.index}"
  billing_account = var.base_billing_account
}

# Service Accounts

resource "google_service_account" "test" {
  count = local.n

  project = var.base_project_id

  account_id = "${local.prefix}-svcacct-${count.index}-${random_id.test[count.index].hex}"
}

# Buckets

resource "google_storage_bucket" "test" {
  count = local.n

  project  = var.base_project_id
  location = local.location

  name = "${local.prefix}-bkt-${count.index}-${random_id.test[count.index].hex}"
}

# KMS

resource "google_kms_key_ring" "test" {
  count = local.n

  project  = var.base_project_id
  name     = "${local.prefix}-keyrng-${count.index}-${random_id.test[count.index].hex}"
  location = local.location
}

resource "google_kms_crypto_key" "test" {
  count = local.n

  name = "${local.prefix}-key-${count.index}-${random_id.test[count.index].hex}"

  key_ring = google_kms_key_ring.test[count.index].id
}

# Pubsub

resource "google_pubsub_topic" "test" {
  count = local.n

  project = var.base_project_id
  name    = "${local.prefix}-tpc-${count.index}-${random_id.test[count.index].hex}"
}

resource "google_pubsub_subscription" "test" {
  count = local.n

  project = var.base_project_id

  topic = google_pubsub_topic.test[count.index].name
  name  = "${local.prefix}-sub-${count.index}-${random_id.test[count.index].hex}"
}

# Subnets

resource "google_compute_subnetwork" "test" {
  count = local.n

  project       = var.base_project_id
  region        = local.location
  name          = "${local.prefix}-snet-${count.index}-${random_id.test[count.index].hex}"
  ip_cidr_range = local.subnet_cidr[count.index]
  network       = "default"
}

# Secret Manager

resource "google_secret_manager_secret" "test" {
  count = local.n

  project   = var.base_project_id
  secret_id = "${local.prefix}-secret-${count.index}-${random_id.test[count.index].hex}"
  replication {
    user_managed {
      replicas {
        location = local.location
      }
    }
  }
}

# BigQuery Dataset

resource "google_bigquery_dataset" "dataset" {
  count = local.n

  project    = var.base_project_id
  dataset_id = replace("${local.prefix}_ds_${count.index}-${random_id.test[count.index].hex}", "-", "_")
}
