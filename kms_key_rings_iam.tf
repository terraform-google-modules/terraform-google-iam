/**
 * Copyright 2018 Google LLC
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
  Kms Key Ring IAM binding authoritative
 *****************************************/
resource "google_kms_key_ring_iam_binding" "kms_key_ring_iam_authoritative" {
  count = local.kms_key_rings_authoritative_iam ? length(local.bindings_array) : 0

  key_ring_id = element(split(" ", local.bindings_array[count.index]), 0)
  role        = element(split(" ", local.bindings_array[count.index]), 1)

  members = compact(
    split(
      " ",
      element(split("=", local.bindings_array[count.index]), 1),
    ),
  )
}

/******************************************
  Kms Key Ring IAM binding additive
 *****************************************/
resource "google_kms_key_ring_iam_member" "kms_key_ring_iam_additive" {
  count = local.kms_key_rings_additive_iam ? length(local.bindings_array) : 0

  key_ring_id = element(split(" ", local.bindings_array[count.index]), 0)
  member      = element(split(" ", local.bindings_array[count.index]), 1)
  role        = element(split(" ", local.bindings_array[count.index]), 2)
}

