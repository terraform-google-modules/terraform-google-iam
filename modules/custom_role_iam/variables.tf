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

variable "org_id" {
  type        = string
  description = "Organization ID"
}

variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "title" {
  type        = string
  description = "Title of the Custom Role."
}

variable "role_id" {
  type        = string
  description = "ID of the Custom Role."
}

variable "permissions" {
  type        = list(string)
  description = "IAM permissions assigned to Custom Role."
}

variable "description" {
  type        = string
  description = "Description of Custom role."
  default     = "This is a custom role."
}

variable "stage" {
  type        = string
  description = "The current launch stage of the role. Defaults to GA."
  default     = "GA"
}

variable "role_level" {
  type        = string
  description = "String variable to denote if custom role being created is at project or organization level."
  default     = "project"
}
