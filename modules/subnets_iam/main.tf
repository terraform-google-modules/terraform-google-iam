/**
 * Copyright 2023 Google LLC
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
  entities             = var.subnets
  conditional_bindings = var.conditional_bindings
}

/******************************************
  Compute Subnetwork IAM binding authoritative
 *****************************************/
resource "google_compute_subnetwork_iam_binding" "subnet_iam_authoritative" {
  for_each   = module.helper.set_authoritative
  project    = var.project
  region     = var.subnets_region
  subnetwork = module.helper.bindings_authoritative[each.key].name
  role       = module.helper.bindings_authoritative[each.key].role
  members    = module.helper.bindings_authoritative[each.key].members
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
  Compute Subnetwork IAM binding additive
 *****************************************/
resource "google_compute_subnetwork_iam_member" "subnet_iam_additive" {
  for_each   = module.helper.set_additive
  project    = var.project
  region     = var.subnets_region
  subnetwork = module.helper.bindings_additive[each.key].name
  role       = module.helper.bindings_additive[each.key].role
  member     = module.helper.bindings_additive[each.key].member
  dynamic "condition" {
    for_each = module.helper.bindings_additive[each.key].condition.title == "" ? [] : [module.helper.bindings_additive[each.key].condition]
    content {
      title       = module.helper.bindings_additive[each.key].condition.title
      description = module.helper.bindings_additive[each.key].condition.description
      expression  = module.helper.bindings_additive[each.key].condition.expression
    }
  }
}
