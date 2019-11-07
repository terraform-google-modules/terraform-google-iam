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

variable "folders" {
  description = "Folders list to add the IAM policies/bindings"
  default     = []
  type        = list(string)
}

variable "folders_mode" {
  description = "Mode for adding the Folders IAM policies/bindings, additive and authoritative"
  type        = string
  default     = "additive"
}

variable "folders_bindings" {
  description = "Map of role (key) and list of members (value) to add the Folders IAM policies/bindings"
  type        = map(list(string))
}

variable "kms_crypto_keys" {
  description = "KMS Crypto Keys list to add the IAM policies/bindings"
  default     = []
  type        = list(string)
}

variable "kms_crypto_keys_mode" {
  description = "Mode for adding the KMS Crypto Keys IAM policies/bindings, additive and authoritative"
  type        = string
  default     = "additive"
}

variable "kms_crypto_keys_bindings" {
  description = "Map of role (key) and list of members (value) to add the KMS Crypto Keys IAM policies/bindings"
  type        = map(list(string))
}

variable "kms_key_rings" {
  description = "KMS Key Rings list to add the IAM policies/bindings"
  default     = []
  type        = list(string)
}

variable "kms_key_rings_mode" {
  description = "Mode for adding the KMS Key Rings IAM policies/bindings, additive and authoritative"
  type        = string
  default     = "additive"
}

variable "kms_key_rings_bindings" {
  description = "Map of role (key) and list of members (value) to add the KMS Key Rings IAM policies/bindings"
  type        = map(list(string))
}

variable "organizations" {
  description = "Organizations list to add the IAM policies/bindings"
  default     = []
  type        = list(string)
}

variable "organizations_mode" {
  description = "Mode for adding the Organizations IAM policies/bindings, additive and authoritative"
  type        = string
  default     = "additive"
}

variable "organizations_bindings" {
  description = "Map of role (key) and list of members (value) to add the Organizations IAM policies/bindings"
  type        = map(list(string))
}

variable "project" {
  description = "Project to add the IAM policies/bindings"
  default     = ""
  type        = string
}

variable "projects" {
  description = "Projects list to add the IAM policies/bindings"
  default     = []
  type        = "list"
}

variable "projects_mode" {
  description = "Mode for adding the Projects IAM policies/bindings, additive and authoritative"
  type        = string
  default     = "additive"
}

variable "projects_bindings" {
  description = "Map of role (key) and list of members (value) to add the Projects IAM policies/bindings"
  type        = map(list(string))
}

variable "pubsub_subscriptions" {
  description = "PubSub Subscriptions list to add the IAM policies/bindings"
  default     = []
  type        = list(string)
}

variable "pubsub_subscriptions_mode" {
  description = "Mode for adding the PubSub Subscriptions IAM policies/bindings, additive and authoritative"
  type        = string
  default     = "additive"
}

variable "pubsub_subscriptions_bindings" {
  description = "Map of role (key) and list of members (value) to add the PubSub Subscriptions IAM policies/bindings"
  type        = map(list(string))
}

variable "pubsub_topics" {
  description = "PubSub Topics list to add the IAM policies/bindings"
  default     = []
  type        = list(string)
}

variable "pubsub_topics_mode" {
  description = "Mode for adding the PubSub Topics IAM policies/bindings, additive and authoritative"
  type        = string
  default     = "additive"
}

variable "pubsub_topics_bindings" {
  description = "Map of role (key) and list of members (value) to add the PubSub Topics IAM policies/bindings"
  type        = map(list(string))
}

variable "service_accounts" {
  description = "Service Accounts list to add the IAM policies/bindings"
  default     = []
  type        = list(string)
}

variable "service_accounts_mode" {
  description = "Mode for adding the Service Accounts IAM policies/bindings, additive and authoritative"
  type        = string
  default     = "additive"
}

variable "service_accounts_bindings" {
  description = "Map of role (key) and list of members (value) to add the Service Accounts IAM policies/bindings"
  type        = map(list(string))
}

variable "storage_buckets" {
  description = "Storage Buckets list to add the IAM policies/bindings"
  default     = []
  type        = list(string)
}

variable "storage_buckets_mode" {
  description = "Mode for adding the Storage Buckets IAM policies/bindings, additive and authoritative"
  type        = string
  default     = "additive"
}

variable "storage_buckets_bindings" {
  description = "Map of role (key) and list of members (value) to add the Storage Buckets IAM policies/bindings"
  type        = map(list(string))
}

variable "subnets" {
  description = "Subnets list to add the IAM policies/bindings"
  default     = []
  type        = list(string)
}

variable "subnets_mode" {
  description = "Mode for adding the Subnets IAM policies/bindings, additive and authoritative"
  type        = string
  default     = "additive"
}

variable "subnets_bindings" {
  description = "Map of role (key) and list of members (value) to add the Subnets IAM policies/bindings"
  type        = map(list(string))
}

variable "subnets_region" {
  description = "Subnets region"
  type        = string
}
