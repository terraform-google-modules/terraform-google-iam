/**
 * Copyright 2024 Google LLC
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
  Run helper module to get generic calculated data
 *****************************************/
module "helper" {
  source   = "../helper"
  bindings = var.bindings
  mode     = var.mode
  entities = coalesce(var.entity_ids.instance_ids, var.entity_ids.repository_ids)
}

/******************************************
  SSM Instance IAM binding authoritative
 *****************************************/
resource "google_secure_source_manager_instance_iam_binding" "ssm_instance_iam_authoritative" {
  for_each    = var.entity_ids.instance_ids == null ? [] : module.helper.set_authoritative
  project     = var.project
  instance_id = module.helper.bindings_authoritative[each.key].name
  location    = var.location
  role        = module.helper.bindings_authoritative[each.key].role
  members     = module.helper.bindings_authoritative[each.key].members
}

/******************************************
  SSM Instance IAM binding additive
 *****************************************/
resource "google_secure_source_manager_instance_iam_member" "ssm_instance_iam_additive" {
  for_each    = var.entity_ids.instance_ids == null ? [] : module.helper.set_additive
  project     = var.project
  instance_id = module.helper.bindings_additive[each.key].name
  location    = var.location
  role        = module.helper.bindings_additive[each.key].role
  member      = module.helper.bindings_additive[each.key].member
}

/******************************************
  SSM Repos binding authoritative
 *****************************************/
resource "google_secure_source_manager_repository_iam_binding" "ssm_repository_iam_authoritative" {
  for_each      = var.entity_ids.repository_ids == null ? [] : module.helper.set_authoritative
  project       = var.project
  repository_id = module.helper.bindings_authoritative[each.key].name
  location      = var.location
  role          = module.helper.bindings_authoritative[each.key].role
  members       = module.helper.bindings_authoritative[each.key].members
}

/******************************************
  SSM Repos IAM binding additive
 *****************************************/
resource "google_secure_source_manager_repository_iam_member" "ssm_repository_iam_additive" {
  for_each      = var.entity_ids.repository_ids == null ? [] : module.helper.set_additive
  project       = var.project
  repository_id = module.helper.bindings_additive[each.key].name
  location      = var.location
  role          = module.helper.bindings_additive[each.key].role
  member        = module.helper.bindings_additive[each.key].member
}
