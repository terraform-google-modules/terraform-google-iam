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
  bindings_formatted   = distinct(flatten([for storage_bucket in var.storage_buckets : [for value in flatten([for k, v in var.bindings : [for val in v : { "role_name" = k, "member_id" = val }]]) : merge({ "storage_bucket_name" = storage_bucket }, value)]]))
}

/******************************************
  Storage Bucket IAM binding authoritative
 *****************************************/
resource "google_storage_bucket_iam_binding" "storage_bucket_iam_authoritative" {
  count = var.bindings_num > 0 ? var.bindings_num * local.authoritative : length(distinct(local.bindings_formatted[*].role_name)) * local.authoritative * local.storage_bucket_count

  bucket = local.bindings_formatted[count.index].storage_bucket_name
  role   = local.bindings_formatted[count.index].role_name
  members = [
    for binded in local.bindings_formatted :
    binded.member_id if binded.storage_bucket_name == local.bindings_formatted[count.index].storage_bucket_name && binded.role_name == local.bindings_formatted[count.index].role_name
  ]
}

/******************************************
  Storage Bucket IAM binding additive
 *****************************************/
resource "google_storage_bucket_iam_member" "storage_bucket_iam_additive" {
  count = var.bindings_num > 0 ? var.bindings_num * local.additive * local.storage_bucket_count : length(local.bindings_formatted) * local.additive

  bucket = local.bindings_formatted[count.index].storage_bucket_name
  role   = local.bindings_formatted[count.index].role_name
  member = local.bindings_formatted[count.index].member_id
}

