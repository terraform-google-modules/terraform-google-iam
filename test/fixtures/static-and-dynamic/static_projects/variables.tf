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

variable "folder_id" {
  type        = string
  description = "Folder to create resources in, e.g. folders/12345678"
}

variable "billing_account" {
  type        = string
  description = "Billing account to associate created projects with."
}

variable "random_hexes" {
  type        = list(string)
  description = "List of pre-generated random id hexes. Required for 'for_each' to work when testing static scerarios."
}

variable "mode" {
  type        = string
  description = "Mode for adding the IAM policies/bindings, additive and authoritative"
}

variable "n" {
  type        = number
  description = "Amount of projects to create"
}

variable "prefix" {
  type        = string
  description = "Prefix for the project name"
}
