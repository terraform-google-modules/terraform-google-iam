/**
 * Copyright 2021 Google LLC
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
  source               = "../helper"
  bindings             = var.bindings
  mode                 = var.mode
  entities             = var.secrets
  conditional_bindings = var.conditional_bindings
}

/******************************************
  Secret Manager IAM binding authoritative
 *****************************************/
resource "google_secret_manager_secret_iam_binding" "secret_manager_iam_authoritative" {
  for_each  = module.helper.set_authoritative
  project   = var.project
  secret_id = module.helper.bindings_authoritative[each.key].name
  role      = module.helper.bindings_authoritative[each.key].role
  members   = module.helper.bindings_authoritative[each.key].members
  dynamic "condition" {
    for_each = module.helper.bindings_authoritative[each.key].condition.title == "" ? [] : [module.helper.bindings_authoritative[each.key].condition]
    content {
      title       = module.helper.bindings_authoritative[each.key].condition.title
      description = module.helper.bindings_authoritative[each.key].condition.description
      expression  = module.helper.bindings_authoritative[each.key].condition.expression
    }
  }
}

/******************************************
  Secret Manager IAM binding additive
 *****************************************/
resource "google_secret_manager_secret_iam_member" "secret_manager_iam_additive" {
  for_each  = module.helper.set_additive
  project   = var.project
  secret_id = module.helper.bindings_additive[each.key].name
  role      = module.helper.bindings_additive[each.key].role
  member    = module.helper.bindings_additive[each.key].member
  dynamic "condition" {
    for_each = module.helper.bindings_additive[each.key].condition.title == "" ? [] : [module.helper.bindings_additive[each.key].condition]
    content {
      title       = module.helper.bindings_additive[each.key].condition.title
      description = module.helper.bindings_additive[each.key].condition.description
      expression  = module.helper.bindings_additive[each.key].condition.expression
    }
  }
}
