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
  Organization IAM binding authoritative
 *****************************************/
resource "google_organization_iam_binding" "organization_iam_authoritative" {
  for_each = {
    for binding in(local.organizations_authoritative_iam ? local.bindings_array : []) :
    binding => {
      org_id  = element(split(" ", binding), 0)
      role    = element(split(" ", binding), 1)
      members = compact(split(" ", element(split("=", binding), 1)))
    }
  }

  org_id  = each.value.org_id
  role    = each.value.role
  members = each.value.members
}

/******************************************
  Organization IAM binding additive
 *****************************************/
resource "google_organization_iam_member" "organization_iam_additive" {
  for_each = {
    for binding in(local.organizations_additive_iam ? local.bindings_array : []) :
    binding => {
      org_id = element(split(" ", binding), 0)
      member = element(split(" ", binding), 1)
      role   = element(split(" ", binding), 2)
    }
  }

  org_id = each.value.org_id
  member = each.value.member
  role   = each.value.role
}
