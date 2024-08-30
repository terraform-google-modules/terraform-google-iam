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

variable "entitlement_id" {
  type        = string
  description = "The ID to use for this Entitlement. This will become the last part of the resource name. This value should be 4-63 characters. This value should be unique among all other Entitlements under the specified parent"
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{3,62}$", var.entitlement_id))
    error_message = "ERROR: entitlement_id must contain only Letters(lowercase), number, hyphen and should be 4-63 characters"
  }
}
variable "location" {
  type        = string
  description = "The region of the Entitlement resource"
  default     = "global"
}

variable "parent_id" {
  type        = string
  description = "The ID of organization, folder, or project to create the entitlement in"
}

variable "parent_type" {
  type        = string
  description = "Parent type. Can be organization, folder, or project to create the entitlement in"
}

variable "requester_justification" {
  type        = bool
  description = "If the requester is required to provide a justification"
  default     = true
}

variable "require_approver_justification" {
  type        = bool
  description = "Do the approvers need to provide a justification for their actions"
  default     = true
}

variable "entitlement_requesters" {
  type        = list(string)
  description = "Required List of users, groups, service accounts or domains who can request grants using this entitlement. Can be one or more of Google Account email, Google Group, Service account, or Google Workspace domain"
}

variable "entitlement_approvers" {
  type        = list(string)
  description = "Required List of users, groups or service accounts who can approve this entitlement. Can be one or more of Google Account email, Google Group or Service account"
}

variable "entitlement_approval_notification_recipients" {
  type        = list(string)
  description = "List of email addresses to be notified when a request is granted"
  default     = null
}

variable "entitlement_availability_notification_recipients" {
  type        = list(string)
  description = "List of email addresses to be notified when a entitlement is created. These email addresses will receive an email about availability of the entitlement"
  default     = null
}

variable "max_request_duration_hours" {
  type        = number
  description = "The maximum amount of time for which access would be granted for a request. A requester can choose to ask for access for less than this duration but never more"
  default     = 1
}

variable "role_bindings" {
  type = list(object({
    role                 = string
    condition_expression = optional(string)
  }))
  description = "The maximum amount of time for which access would be granted for a request. A requester can choose to ask for access for less than this duration but never more"
}
