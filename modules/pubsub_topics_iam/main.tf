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
  pubsub_topic_count = var.pubsub_topics_num == 0 ? length(var.pubsub_topics) : var.pubsub_topics_num
  bindings_formated  = distinct(flatten([ for pubsub_topic in var.pubsub_topics : [ for key,value in flatten([ for k,v in var.bindings : [ for val in v : { "role_name" = k, "member_id" = val } ] ]) : merge({ "pubsub_topic_name" = pubsub_topic }, value ) ] ]))
}

/******************************************
  PubSub Topic IAM binding authoritative
 *****************************************/
resource "google_pubsub_topic_iam_binding" "pubsub_topic_iam_authoritative" {
  count   = var.bindings_num > 0 ? var.bindings_num * local.authoritative : length(distinct(local.bindings_formated[*].role_name)) * local.authoritative * local.pubsub_topic_count

  topic   = local.bindings_formated[count.index].pubsub_topic_name
  role    = local.bindings_formated[count.index].role_name
  members = compact([
    for binded in local.bindings_formated:
    binded.pubsub_topic_name == local.bindings_formated[count.index].pubsub_topic && binded.role_name == local.bindings_formated[count.index].role_name ? binded.member_id : ""
  ])
}

/******************************************
  PubSub Topic IAM binding additive
 *****************************************/
resource "google_pubsub_topic_iam_member" "pubsub_topic_iam_additive" {
  count  = var.bindings_num > 0 ? var.bindings_num * local.additive : length(local.bindings_formated) * local.additive

  topic  = local.bindings_formated[count.index].pubsub_topic_name
  role   = local.bindings_formated[count.index].role_name
  member = local.bindings_formated[count.index].member_id
}

