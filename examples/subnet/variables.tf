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

variable "credentials_file_path" {
  description = "Service account json auth path"
}

variable "project" {
  description = "The project where the subnet resides"
}

variable "region" {
  description = "The region where the subnet resides"
}

variable "group_email" {
  description = "Email for group to receive roles (ex. group@example.com)"
}

variable "sa_email" {
  description = "Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com)"
}

variable "user_email" {
  description = "Email for group to receive roles (Ex. user@example.com)"
}

/******************************************
  Subnet_iam_binding variables
 *****************************************/
variable "subnet_one" {
  description = "First subnet id to add the IAM policies/bindings"
}

variable "subnet_two" {
  description = "Second subnet id to add the IAM policies/bindings"
}

