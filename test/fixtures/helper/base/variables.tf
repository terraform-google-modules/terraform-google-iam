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

variable "base_billing_account" {
  description = "The billing account id associated with the project, e.g. XXXXXX-YYYYYY-ZZZZZZ"
}

variable "base_parent_id" {
  description = "Folder to create resources in, e.g. folders/12345678"
}

variable "base_location" {
  description = "Region for subnetwork tests."
}

variable "base_project_id" {
  description = "Project ID of the test fixture project.  Used to avoid timing issues with recently created projects."
}

variable "subnet_cidr" {
  description = "List of CIDRs to use when creating fixture subnetworks. Used to avoid the resource locking between test suites."
}
