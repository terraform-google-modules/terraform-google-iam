/**
 * Copyright 2022 Google LLC
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

variable "group_email" {
  type        = string
  description = "Email for group to receive roles (ex. group@example.com)"
}

variable "sa_email" {
  type        = string
  description = "Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com)"
}

variable "user_email" {
  type        = string
  description = "Email for group to receive roles (Ex. user@example.com)"
}

/******************************************
  pubsub_topic_iam_binding variables
 *****************************************/
variable "tasks_queue_project" {
  type        = string
  description = "Project id of the Tasks Queue"
}

variable "tasks_queue_location" {
  type        = string
  description = "Region of the Tasks Queue"
}

variable "tasks_queue_one" {
  type        = string
  description = "First Tasks Queue to add the IAM policies/bindings"
}

variable "tasks_queue_two" {
  type        = string
  description = "Second Tasks Queue to add the IAM policies/bindings"
}

