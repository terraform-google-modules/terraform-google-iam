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
  Locals configuration for module logic
 *****************************************/
locals {
  entities     = var.projects == [] ? [var.project] : var.projects
  entities_num = var.projects_num
}

/******************************************
  Project IAM binding authoritative
 *****************************************/

resource "google_project_iam_binding" "project_iam_authoritative" {
  count   = local.count_authoritative
  project = local.bindings_by_role[count.index].name
  role    = local.bindings_by_role[count.index].role
  members = local.bindings_by_role[count.index].members
}

/******************************************
  Project IAM binding additive
 *****************************************/
resource "google_project_iam_member" "project_iam_additive" {
  count   = local.count_additive
  project = local.bindings_by_member[count.index].name
  role    = local.bindings_by_member[count.index].role
  member  = local.bindings_by_member[count.index].member
}
