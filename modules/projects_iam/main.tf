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
  entities     = var.projects == [] ? [var.project] : var.projects
  entities_num = var.projects_num
}

/******************************************
  Project IAM binding authoritative
 *****************************************/

# static

resource "google_project_iam_binding" "project_iam_authoritative_static" {
  for_each = module.helper.for_each_authoritative
  project  = each.value.name
  role     = each.value.role
  members  = each.value.members
}

# dynamic (when referencing outputs from resources obtained asynchronously)

resource "google_project_iam_binding" "project_iam_authoritative" {
  count   = module.helper.count_authoritative
  project = module.helper.bindings_by_role[count.index].name
  role    = module.helper.bindings_by_role[count.index].role
  members = module.helper.bindings_by_role[count.index].members
}

/******************************************
  Project IAM binding additive
 *****************************************/

# static

resource "google_project_iam_member" "project_iam_additive_static" {
  for_each = module.helper.for_each_additive
  project  = each.value.name
  role     = each.value.role
  member   = each.value.member
}

# dynamic (when referencing outputs from resources obtained asynchronously)

resource "google_project_iam_member" "project_iam_additive" {
  count   = module.helper.count_additive
  project = module.helper.bindings_by_member[count.index].name
  role    = module.helper.bindings_by_member[count.index].role
  member  = module.helper.bindings_by_member[count.index].member
}
