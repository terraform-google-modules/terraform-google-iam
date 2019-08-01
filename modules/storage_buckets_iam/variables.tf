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
variable "storage_buckets" {
  description = "Storage Buckets list to add the IAM policies/bindings"
  default     = []
  type        = list(string)
}

variable "storage_buckets_num" {
  description = "Number of Storage Buckets, in case using dependcies of outher resources's outputs"
  default     = 0
  type        = number
}

variable "mode" {
  description = "Mode for adding the IAM policies/bindings, additive and authoritative"
  default     = "additive"
}

variable "bindings" {
  description = "Map of role (key) and list of members (value) to add the IAM policies/bindings"
  type        = map 
}

variable "bindings_num" {
  description = "Number of bindings, in case using dependcies of outher resources's outputs"
  default     = 0
  type        = number
}
