/**
 * Copyright 2024 Google LLC
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

variable "project" {
  description = "Project to add the IAM policies/bindings"
  type        = string
}

# variable "instance_ids" {
#   description = "List of secure source manager instance names"
#   type        = list(string)
# }

variable "entity_ids" {
  description = "List of secure source manager instance or repository names"
  type = object({
    instance_ids   = optional(list(string))
    repository_ids = optional(list(string))
  })
  validation {
    # condition     = (try(length(var.entity_ids.instance_ids),0) > 0 && !(try(length(var.entity_ids.repository_ids),0) > 0)) || (!(try(length(var.entity_ids.instance_ids),0)) > 0 && try(length(var.entity_ids.repository_ids),0) > 0)
    condition     = (try(length(var.entity_ids.instance_ids), 0) > 0 && !(try(length(var.entity_ids.repository_ids), 0) > 0)) || (!(try(length(var.entity_ids.instance_ids), 0) > 0) && try(length(var.entity_ids.repository_ids), 0) > 0)
    error_message = "ERROR: one of instance_ids or repository_ids must be specified and they both are mutually exclusive"
  }
}

variable "mode" {
  description = "Mode for adding the IAM policies/bindings, additive and authoritative"
  type        = string
  default     = "additive"
}

variable "bindings" {
  description = "Map of role (key) and list of members (value) to add the IAM policies/bindings"
  type        = map(any)
}

variable "location" {
  description = "The location for the secure source manager Instance"
  type        = string
}
