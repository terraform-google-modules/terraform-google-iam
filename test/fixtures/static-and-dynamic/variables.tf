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

variable "project_id" {
  type        = string
  description = "Project ID of the test fixture project.  Used to avoid timing issues with recently created projects."
}

variable "member1" {
  type        = string
  description = "Member created for binding with roles."
}

variable "member2" {
  type        = string
  description = "Member created for binding with roles."
}

variable "random_hexes" {
  type        = list(string)
  description = "List of pre-generated random id hexes. Required for 'for_each' to work when testing static scerarios."
}

variable "prefix" {
  type        = string
  default     = "prj"
  description = "Unique string to use as an additional prefix for project name generation. Useful for local testing to rerun the tests without redoing the 'setup' step all over."
}

variable "roles" {
  type        = number
  default     = 2
  description = "Amount of roles to assign. Useful for testing how the module behaves on updates."
}
