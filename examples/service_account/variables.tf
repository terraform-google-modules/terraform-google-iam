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

variable "group_email" {
  type        = string
  description = "Email for group to receive roles (ex. group@example.com)"
  default     = "goose_net_admins@goosecorp.org"
}

variable "sa_email" {
  type        = string
  description = "Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com)"
  default     = "sa-tf-test-receiver-01@ci-iam-0c5f.iam.gserviceaccount.com"
}

variable "user_email" {
  type        = string
  description = "Email for group to receive roles (Ex. user@example.com)"
  default     = "awmalik@google.com"

}

/******************************************
  service_account_iam_binding variables
 *****************************************/
variable "service_account_project" {
  type        = string
  description = "Project id of the service account"
  default     = "ci-iam-0c5f"
}

variable "service_account_one" {
  type        = string
  description = "First service Account to add the IAM policies/bindings"
  default     = "sa-tf-test-01@ci-iam-0c5f.iam.gserviceaccount.com"
}

variable "service_account_two" {
  type        = string
  description = "First service Account to add the IAM policies/bindings"
  default     = "sa-tf-test-02@ci-iam-0c5f.iam.gserviceaccount.com"
}
