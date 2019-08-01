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

  folders      = var.folders
  folders_num  = var.folders_num
  mode         = var.folders_mode
  bindings     = var.folders_bindings
  bindings_num = var.folders_bindings_num
}

module "kms_crypto_keys_iam" {
  source = "./modules/kms_crypto_keys_iam"

  kms_crypto_keys     = var.kms_crypto_keys
  kms_crypto_keys_num = var.kms_crypto_keys_num
  mode                = var.kms_crypto_keys_mode
  bindings            = var.kms_crypto_keys_bindings
  bindings_num        = var.kms_crypto_keys_bindings_num
}

module "kms_key_rings_iam" {
  source = "./modules/kms_key_rings_iam"

  kms_key_rings     = var.kms_key_rings
  kms_key_rings_num = var.kms_key_rings_num
  mode              = var.kms_key_rings_mode
  bindings          = var.kms_key_rings_bindings
  bindings_num      = var.kms_key_rings_bindings_num
}

module "organizations_iam" {
  source = "./modules/organizations_iam"

  organizations     = var.organizations
  organizations_num = var.organizations_num
  mode              = var.organizations_mode
  bindings          = var.organizations_bindings
  bindings_num      = var.organizations_bindings_num
}

module "projects_iam" {
  source = "./modules/projects_iam"

  project      = var.project
  projects     = var.projects
  projects_num = var.projects_num
  mode         = var.projects_mode
  bindings     = var.projects_bindings
  bindings_num = var.projects_bindings_num
}

module "pubsub_subscriptions_iam" {
  source = "./modules/pubsub_subscriptions_iam"

  project                  = var.project
  pubsub_subscriptions     = var.pubsub_subscriptions
  pubsub_subscriptions_num = var.pubsub_subscriptions_num
  mode                     = var.pubsub_subscriptions_mode
  bindings                 = var.pubsub_subscriptions_bindings
  bindings_num             = var.pubsub_subscriptions_bindings_num
}

module "pubsub_topics_iam" {
  source = "./modules/pubsub_topics_iam"

  project           = var.project
  pubsub_topics     = var.pubsub_topics
  pubsub_topics_num = var.pubsub_topics_num
  mode              = var.pubsub_topics_mode
  bindings          = var.pubsub_topics_bindings
  bindings_num      = var.pubsub_topics_bindings_num
}

module "service_accounts_iam" {
  source = "./modules/service_accounts_iam"

  project              = var.project
  service_accounts     = var.service_accounts
  service_accounts_num = var.service_accounts_num
  mode                 = var.service_accounts_mode
  bindings             = var.service_accounts_bindings
  bindings_num         = var.service_accounts_bindings_num
}

module "storage_buckets_iam" {
  source = "./modules/storage_buckets_iam"

  storage_buckets     = var.storage_buckets
  storage_buckets_num = var.storage_buckets_num
  mode                = var.storage_buckets_mode
  bindings            = var.storage_buckets_bindings
  bindings_num        = var.storage_buckets_bindings_num
}

module "subnets_iam" {
  source = "./modules/subnets_iam"

  project        = var.project
  subnets        = var.subnets
  subnets_num    = var.subnets_num
  mode           = var.subnets_mode
  bindings       = var.subnets_bindings
  bindings_num   = var.subnets_bindings_num
  subnets_region = var.subnets_region
}
