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
  authoritative        = var.mode == "authoritative" ? 1 : 0
  additive             = var.mode == "additive" ? 1 : 0
  storage_bucket_count = var.storage_buckets_num == 0 ? length(var.storage_buckets) : var.storage_buckets_num

  bindings_by_role     = distinct(flatten([
    for bucket in var.storage_buckets
    : [
      for role, members in var.bindings
      : { role = role, members = members, bucket = bucket }
    ]
  ]))

  bindings_by_member   = distinct(flatten([
    for binding in local.bindings_by_role
    : [
      for member in binding["members"]
      : { bucket = binding["bucket"], role = binding["role"], member = member }
    ]
  ]))
}

/******************************************
  Storage Bucket IAM binding authoritative
 *****************************************/
resource "google_storage_bucket_iam_binding" "storage_bucket_iam_authoritative" {
  count = local.authoritative * (
    var.bindings_num > 0
      ? var.bindings_num * local.storage_bucket_count
      : length(local.bindings_by_role)
  )

  bucket  = local.bindings_by_role[count.index].bucket
  role    = local.bindings_by_role[count.index].role
  members = local.bindings_by_role[count.index].members
}

/******************************************
  Storage Bucket IAM binding additive
 *****************************************/
resource "google_storage_bucket_iam_member" "storage_bucket_iam_additive" {
  count = local.additive * (
    var.bindings_num > 0
      ? var.bindings_num * local.storage_bucket_count
      : length(local.bindings_by_member)
  )

  bucket = local.bindings_by_member[count.index].bucket
  role   = local.bindings_by_member[count.index].role
  member = local.bindings_by_member[count.index].member
}
