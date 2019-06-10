/**
 * Copyright 2018 Google LLC
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
  Locals configuration for module logic
 *****************************************/
locals {
  authoritative                          = var.mode == "authoritative"
  additive                               = var.mode == "additive"
  projects_authoritative_iam             = length(var.projects) > 0 && local.authoritative
  folders_authoritative_iam              = length(var.folders) > 0 && local.authoritative
  organizations_authoritative_iam        = length(var.organizations) > 0 && local.authoritative
  service_accounts_authoritative_iam     = length(var.service_accounts) > 0 && local.authoritative
  pubsub_topics_authoritative_iam        = length(var.pubsub_topics) > 0 && local.authoritative
  pubsub_subscriptions_authoritative_iam = length(var.pubsub_subscriptions) > 0 && local.authoritative
  storage_buckets_authoritative_iam      = length(var.storage_buckets) > 0 && local.authoritative
  subnets_authoritative_iam              = length(var.subnets) > 0 && local.authoritative
  kms_key_rings_authoritative_iam        = length(var.kms_key_rings) > 0 && local.authoritative
  kms_cryto_keys_authoritative_iam       = length(var.kms_crypto_keys) > 0 && local.authoritative
  projects_additive_iam                  = length(var.projects) > 0 && local.additive
  folders_additive_iam                   = length(var.folders) > 0 && local.additive
  organizations_additive_iam             = length(var.organizations) > 0 && local.additive
  service_accounts_additive_iam          = length(var.service_accounts) > 0 && local.additive
  pubsub_topics_additive_iam             = length(var.pubsub_topics) > 0 && local.additive
  pubsub_subscriptions_additive_iam      = length(var.pubsub_subscriptions) > 0 && local.additive
  storage_buckets_additive_iam           = length(var.storage_buckets) > 0 && local.additive
  subnets_additive_iam                   = length(var.subnets) > 0 && local.additive
  kms_key_rings_additive_iam             = length(var.kms_key_rings) > 0 && local.additive
  kms_cryto_keys_additive_iam            = length(var.kms_crypto_keys) > 0 && local.additive

  # In order to retrieve the project from the provider, this variable takes it from a data source (google_project.project_from_provider) and avoid an error if the count for that resource is 0
  take_project_from_provider = var.project == "" && length(var.organizations) == 0 && length(var.folders) == 0 && length(var.projects) == 0 && length(var.storage_buckets) == 0 && length(var.kms_crypto_keys) == 0 && length(var.kms_key_rings) == 0 && length(var.subnets) == 0
  resources_project_tmp = element(
    coalescelist(data.google_project.project_from_provider.*.project_id, [""]),
    1,
  )
  resources_project = local.take_project_from_provider ? local.resources_project_tmp : var.project

  # Selects the affected resources array
  objects_affected = coalescelist(
    var.storage_buckets,
    var.organizations,
    var.folders,
    var.projects,
    var.subnets,
    var.service_accounts,
    var.pubsub_topics,
    var.pubsub_subscriptions,
    var.kms_key_rings,
    var.kms_crypto_keys,
  )

  #objects_affected = "${coalescelist(list(var.storage_buckets), list(var.organizations))}"

  # Please see the data.external.additive_bindings_temp_struct resource for information about the behavior of the variables below
  bindings_array = compact(
    split(
      ",",
      data.external.additive_bindings_temp_struct.result["data"],
    ),
  )
  service_accounts_passed = local.service_accounts_authoritative_iam || local.service_accounts_additive_iam ? "1" : "0"
  kms_crypto_keys_passed  = local.kms_cryto_keys_additive_iam || local.kms_cryto_keys_authoritative_iam ? "1" : "0"
  kms_key_rings_passed    = local.kms_key_rings_additive_iam || local.kms_key_rings_authoritative_iam ? "1" : "0"
}

/******************************************
  Temp struct construction for additive bindings
 *****************************************/
data "external" "additive_bindings_temp_struct" {
  /*
 * This external resource is used for construct the structures for both additive and authoritative modes,
 * in order to create the proper resources for Terraform.
 *
 * Due to var.bindings is a map and the resources affected are within a list,
 * is necessary to construct special structures
 *
 * Having a bindings map:
 * {
 *   "roles/role1" = ["member1", "member2"]
 *   "roles/role2" = ["member3", "member1"]
 * }
 *
 * And a list of folders:
 * ["123", "456", "789"]
 *
 * For additive mode, the needed structure is:
 *
 * [
 *   "789 member1 role2",
 *   "456 member1 role2",
 *   "123 member1 role2",
 *   "789 member3 role2",
 *   "456 member3 role2",
 *   "123 member3 role2",
 *   "789 member2 role1",
 *   "456 member2 role1",
 *   "123 member2 role1",
 *   "789 member1 role1",
 *   "456 member1 role1",
 *   "123 member1 role1",
 * ]
 *
 * For authoritative mode, the needed structure is:
 *
 * [
 *   "123 roles/role1 =member1 member2",
 *   "456 roles/role1 =member1 member2",
 *   "789 roles/role1 =member1 member2",
 *   "123 roles/role2 =member3 member1",
 *   "456 roles/role2 =member3 member1",
 *   "789 roles/role2 =member3 member1",
 * ]
 *
 */

  program = ["bash", "${path.module}/scripts/create_additive_authoritative_structures.sh", var.mode, jsonencode(var.bindings), jsonencode(local.objects_affected), local.resources_project == "" ? "-1" : local.resources_project, local.service_accounts_passed, local.kms_key_rings_passed, local.kms_crypto_keys_passed]
}

/******************************************
  Project retrieval from provider
 *****************************************/
data "google_project" "project_from_provider" {
  # Only if the project is not specified as a variable, we need the take it from the provider with this resource.
  count = local.take_project_from_provider ? 1 : 0
}

