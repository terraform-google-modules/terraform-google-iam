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

/******************************************
  IAM bindings
 *****************************************/

module "folders_iam" {
  source = "./modules/folders_iam"

  folders  = var.folders
  mode     = var.folders_mode
  bindings = var.folders_bindings
}

module "kms_crypto_keys_iam" {
  source = "./modules/kms_crypto_keys_iam"

  kms_crypto_keys = var.kms_crypto_keys
  mode            = var.kms_crypto_keys_mode
  bindings        = var.kms_crypto_keys_bindings
}

module "kms_key_rings_iam" {
  source = "./modules/kms_key_rings_iam"

  kms_key_rings = var.kms_key_rings
  mode          = var.kms_key_rings_mode
  bindings      = var.kms_key_rings_bindings
}

module "organizations_iam" {
  source = "./modules/organizations_iam"

  organizations = var.organizations
  mode          = var.organizations_mode
  bindings      = var.organizations_bindings
}

module "projects_iam" {
  source = "./modules/projects_iam"

  project  = var.project
  projects = var.projects
  mode     = var.projects_mode
  bindings = var.projects_bindings
}

module "pubsub_subscriptions_iam" {
  source = "./modules/pubsub_subscriptions_iam"

  project              = var.project
  pubsub_subscriptions = var.pubsub_subscriptions
  mode                 = var.pubsub_subscriptions_mode
  bindings             = var.pubsub_subscriptions_bindings
}

module "pubsub_topics_iam" {
  source = "./modules/pubsub_topics_iam"

  project       = var.project
  pubsub_topics = var.pubsub_topics
  mode          = var.pubsub_topics_mode
  bindings      = var.pubsub_topics_bindings
}

module "service_accounts_iam" {
  source = "./modules/service_accounts_iam"

  project          = var.project
  service_accounts = var.service_accounts
  mode             = var.service_accounts_mode
  bindings         = var.service_accounts_bindings
}

module "storage_buckets_iam" {
  source = "./modules/storage_buckets_iam"

  storage_buckets = var.storage_buckets
  mode            = var.storage_buckets_mode
  bindings        = var.storage_buckets_bindings
}

module "subnets_iam" {
  source = "./modules/subnets_iam"

  project        = var.project
  subnets        = var.subnets
  mode           = var.subnets_mode
  bindings       = var.subnets_bindings
  subnets_region = var.subnets_region
}
