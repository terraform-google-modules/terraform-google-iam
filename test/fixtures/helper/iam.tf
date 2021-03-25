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

# Project general bindings
module "iam_binding_project" {
  source   = "../../../modules/projects_iam"
  mode     = var.mode
  projects = module.base.projects
  bindings = local.project_bindings
}

# Project conditional bindings
module "iam_conditional_binding_project" {
  source               = "../../../modules/projects_iam"
  mode                 = var.mode
  projects             = module.base.projects
  conditional_bindings = local.project_conditional_bindings
}

## TODO(jmccune): Disabled as per discussion with Aaron.  Re-enable post 0.12
# considering public pull requests.
# module "iam_binding_organization" {
#   source        = "../../../modules/organizations_iam"
#   mode          = var.mode
#   organizations = [var.org_id]
#   bindings = local.org_bindings
# }

module "iam_binding_folder" {
  source   = "../../../modules/folders_iam"
  mode     = var.mode
  folders  = module.base.folders
  bindings = local.folder_bindings
}

module "iam_binding_subnet" {
  source         = "../../../modules/subnets_iam"
  mode           = var.mode
  project        = var.project_id
  subnets_region = module.base.region
  subnets        = module.base.subnets
  bindings       = local.basic_bindings
}

module "iam_binding_subnet_empty" {
  source         = "../../../modules/subnets_iam"
  mode           = var.mode
  project        = var.project_id
  subnets_region = module.base.region
  subnets        = []
  bindings       = local.basic_bindings
}

module "iam_binding_service_account" {
  source           = "../../../modules/service_accounts_iam"
  mode             = var.mode
  service_accounts = module.base.service_accounts
  project          = var.project_id
  bindings         = local.basic_bindings
}

module "iam_binding_storage_bucket" {
  source          = "../../../modules/storage_buckets_iam"
  mode            = var.mode
  storage_buckets = module.base.buckets
  bindings        = local.bucket_bindings
}

module "iam_binding_kms_crypto_key" {
  source          = "../../../modules/kms_crypto_keys_iam"
  mode            = var.mode
  kms_crypto_keys = module.base.keys
  bindings        = local.basic_bindings
}

module "iam_binding_kms_key_ring" {
  source        = "../../../modules/kms_key_rings_iam"
  mode          = var.mode
  kms_key_rings = module.base.key_rings
  bindings      = local.basic_bindings
}

module "iam_binding_pubsub_subscription" {
  source               = "../../../modules/pubsub_subscriptions_iam"
  mode                 = var.mode
  pubsub_subscriptions = module.base.subscriptions
  project              = var.project_id
  bindings             = local.basic_bindings
}

module "iam_binding_pubsub_topic" {
  source        = "../../../modules/pubsub_topics_iam"
  mode          = var.mode
  pubsub_topics = module.base.topics
  project       = var.project_id
  bindings      = local.basic_bindings
}

module "audit_config" {
  source           = "../../../modules/audit_config"
  project          = var.project_id
  audit_log_config = local.audit_log_config
}

module "iam_binding_secret_manager" {
  source   = "../../../modules/secret_manager_iam"
  mode     = var.mode
  secrets  = module.base.secrets
  project  = var.project_id
  bindings = local.basic_bindings
}
