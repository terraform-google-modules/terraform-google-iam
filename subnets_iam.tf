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
  Subnet IAM binding authoritative
 *****************************************/
resource "google_compute_subnetwork_iam_binding" "subnet_iam_authoritative" {
  provider = google-beta

  for_each = {
    for binding in(local.subnets_authoritative_iam ? local.bindings_array : []) :
    binding => {
      subnetwork = element(split("/", element(split(" ", binding), 0)), 5)
      region     = element(split("/", element(split(" ", binding), 0)), 3)
      project    = element(split("/", element(split(" ", binding), 0)), 1)
      role       = element(split(" ", binding), 1)
      members    = compact(split(" ", element(split("=", binding), 1)))
    }
  }

  subnetwork = each.value.subnetwork
  region     = each.value.region
  project    = each.value.project
  role       = each.value.role
  members    = each.value.members
}

/******************************************
  Subnet IAM binding additive
 *****************************************/
resource "google_compute_subnetwork_iam_member" "subnet_iam_additive" {
  provider = google-beta

  for_each = {
    for binding in(local.subnets_additive_iam ? local.bindings_array : []) :
    binding => {
      subnetwork = element(split("/", element(split(" ", binding), 0)), 5)
      region     = element(split("/", element(split(" ", binding), 0)), 3)
      project    = element(split("/", element(split(" ", binding), 0)), 1)
      member     = element(split(" ", binding), 1)
      role       = element(split(" ", binding), 2)
    }
  }

  subnetwork = each.value.subnetwork
  region     = each.value.region
  project    = each.value.project
  member     = each.value.member
  role       = each.value.role
}
