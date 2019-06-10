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
  subnets = [
    "projects/${google_project_service.compute[0].project}/regions/us-central1/subnetworks/default",
    "projects/${google_project_service.compute[0].project}/regions/us-east1/subnetworks/default",
  ]
}

module "iam_binding_project" {
  source   = "../../.."
  mode     = var.mode
  projects = module.base.projects

  bindings = local.project_bindings
}

module "iam_binding_organization" {
  source        = "../../.."
  mode          = var.mode
  organizations = [var.org_id]

  bindings = local.org_bindings
}

module "iam_binding_folder" {
  source  = "../../.."
  mode    = var.mode
  folders = module.base.folders

  bindings = local.basic_bindings
}

# Needed for iam_binding_subnet.
resource "google_project_service" "compute" {
  count = length(module.base.projects)

  project = module.base.projects[count.index]
  service = "compute.googleapis.com"
}

module "iam_binding_subnet" {
  source = "../../.."
  mode   = var.mode

  subnets = [
    "projects/${google_project_service.compute[0].project}/regions/us-central1/subnetworks/default",
    "projects/${google_project_service.compute[0].project}/regions/us-east1/subnetworks/default",
  ]

  bindings = local.basic_bindings
}

module "iam_binding_service_account" {
  source = "../../.."
  mode   = var.mode

  service_accounts = module.base.service_accounts
  project          = module.base.projects[0]

  bindings = local.basic_bindings
}

module "iam_binding_storage_bucket" {
  source          = "../../.."
  mode            = var.mode
  storage_buckets = module.base.buckets

  bindings = local.bucket_bindings
}

module "iam_binding_kms_crypto_key" {
  source          = "../../.."
  mode            = var.mode
  kms_crypto_keys = module.base.keys

  bindings = local.basic_bindings
}

module "iam_binding_kms_key_ring" {
  source        = "../../.."
  mode          = var.mode
  kms_key_rings = module.base.key_rings

  bindings = local.basic_bindings
}

module "iam_binding_pubsub_subscription" {
  source               = "../../.."
  mode                 = var.mode
  pubsub_subscriptions = module.base.subscriptions
  project              = module.base.projects[0]

  bindings = local.basic_bindings
}

module "iam_binding_pubsub_topic" {
  source        = "../../.."
  mode          = var.mode
  pubsub_topics = module.base.topics
  project       = module.base.projects[0]

  bindings = local.basic_bindings
}

