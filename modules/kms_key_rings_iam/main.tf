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
  Locals configuration for module logic
 *****************************************/
locals {
  authoritative      = var.mode == "authoritative" ? 1 : 0
  additive           = var.mode == "additive" ? 1 : 0
  kms_key_ring_count = var.kms_key_rings_num == 0 ? length(var.kms_key_rings) : var.kms_key_rings_num
  bindings_formated  = distinct(flatten([ for kms_key_ring in var.kms_key_rings : [ for key,value in flatten([ for k,v in var.bindings : [ for val in v : { "role_name" = k, "member_id" = val } ] ]) : merge({ "kms_key_ring_name" = kms_key_ring }, value ) ] ]))
}

/******************************************
  KMS Key Ring IAM binding authoritative
 *****************************************/
resource "google_kms_key_ring_iam_binding" "kms_key_ring_iam_authoritative" {
  count       = var.bindings_num > 0 ? var.bindings_num * local.authoritative : length(distinct(local.bindings_formated[*].role_name)) * local.authoritative * local.kms_key_ring_count

  key_ring_id = local.bindings_formated[count.index].kms_key_ring_name
  role        = local.bindings_formated[count.index].role_name
  members     = compact([
    for binded in local.bindings_formated:
    binded.kms_key_ring_name == local.bindings_formated[count.index].kms_key_ring && binded.role_name == local.bindings_formated[count.index].role_name ? binded.member_id : ""
  ])
}

/******************************************
  KMS Key Ring IAM binding additive
 *****************************************/
resource "google_kms_key_ring_iam_member" "kms_key_ring_iam_additive" {
  count       = var.bindings_num > 0 ? var.bindings_num * local.additive : length(local.bindings_formated) * local.additive

  key_ring_id = local.bindings_formated[count.index].kms_key_ring_name
  role        = local.bindings_formated[count.index].role_name
  member      = local.bindings_formated[count.index].member_id
}

