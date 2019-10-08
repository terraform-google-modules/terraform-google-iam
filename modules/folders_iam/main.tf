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
  Run helper module to get generic calculated data
 *****************************************/
module "helper" {
  source       = "../helper"
  bindings     = var.bindings
  bindings_num = var.bindings_num
  mode         = var.mode
  entities     = var.folders
  entities_num = var.folders_num
}

/******************************************
  Folder IAM binding authoritative
 *****************************************/
resource "google_folder_iam_binding" "folder_iam_authoritative" {
  count   = module.helper.count_authoritative
  folder  = "folders/${module.helper.bindings_by_role[count.index].name}"
  role    = module.helper.bindings_by_role[count.index].role
  members = module.helper.bindings_by_role[count.index].members
}

/******************************************
  Folder IAM binding additive
 *****************************************/
resource "google_folder_iam_member" "folder_iam_additive" {
  count  = module.helper.count_additive
  folder = "folders/${module.helper.bindings_by_member[count.index].name}"
  role   = module.helper.bindings_by_member[count.index].role
  member = module.helper.bindings_by_member[count.index].member
}
