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
  source   = "../helper"
  bindings = var.bindings
  mode     = var.mode
  entities = var.cloud_run_services
}

/******************************************
  Cloud Run Servive IAM binding authoritative
 *****************************************/
resource "google_cloud_run_service_iam_binding" "cloud_run_iam_authoritative" {
  for_each = module.helper.set_authoritative
  project  = var.project
  location = var.location
  service  = module.helper.bindings_authoritative[each.key].name
  role     = module.helper.bindings_authoritative[each.key].role
  members  = module.helper.bindings_authoritative[each.key].members
}

/******************************************
   Cloud Run Servive IAM binding additive
 *****************************************/
resource "google_cloud_run_service_iam_member" "cloud_run_iam_additive" {
  for_each = module.helper.set_additive
  project  = var.project
  location = var.location
  service  = module.helper.bindings_additive[each.key].name
  role     = module.helper.bindings_additive[each.key].role
  member   = module.helper.bindings_additive[each.key].member
}
