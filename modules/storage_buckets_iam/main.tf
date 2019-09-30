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
  entities     = var.storage_buckets
  entities_num = var.storage_buckets_num
}

/******************************************
  Storage Bucket IAM binding authoritative
 *****************************************/
resource "google_storage_bucket_iam_binding" "storage_bucket_iam_authoritative" {
  count   = local.count_authoritative
  bucket  = local.bindings_by_role[count.index].name
  role    = local.bindings_by_role[count.index].role
  members = local.bindings_by_role[count.index].members
}

/******************************************
  Storage Bucket IAM binding additive
 *****************************************/
resource "google_storage_bucket_iam_member" "storage_bucket_iam_additive" {
  count  = local.count_additive
  bucket = local.bindings_by_member[count.index].name
  role   = local.bindings_by_member[count.index].role
  member = local.bindings_by_member[count.index].member
}
