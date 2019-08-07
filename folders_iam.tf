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
  Folder IAM binding authoritative
 *****************************************/
resource "google_folder_iam_binding" "folder_iam_authoritative" {
  for_each = {
    for binding in(local.folders_authoritative_iam ? local.bindings_array : []) :
    binding => {
      folder  = "folders/${replace(element(split(" ", binding), 0), "folders/", "")}"
      role    = element(split(" ", binding), 1)
      members = compact(split(" ", element(split("=", binding), 1), ), )
    }
  }

  folder  = each.value.folder
  role    = each.value.role
  members = each.value.members
}

/******************************************
  Folder IAM binding additive
 *****************************************/
resource "google_folder_iam_member" "folder_iam_additive" {
  for_each = {
    for binding in(local.folders_additive_iam ? local.bindings_array : []) :
    binding => {
      folder = "folders/${replace(element(split(" ", binding), 0), "folders/", "")}"
      member = element(split(" ", binding), 1)
      role   = element(split(" ", binding), 2)
    }
  }

  folder = each.value.folder
  member = each.value.member
  role   = each.value.role
}
