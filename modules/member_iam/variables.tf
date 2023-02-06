/**
 * Copyright 2023 Google LLC
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

variable "service_account_address" {
  description = "Service account address"
  type        = string
}

variable "project_id" {
  description = "Project id"
  type        = string
}

variable "project_roles" {
  description = "List of IAM roles"
  type        = list(string)
}

variable "prefix" {
  description = "Prefix member or group or serviceaccount"
  type        = string
  default     = "serviceAccount"
}

