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

locals {
  credentials_file_path = "${var.credentials_file_path}"
}

/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  credentials = "${file(local.credentials_file_path)}"
  project     = "${var.service_account_project}"
}

provider "google-beta" {
  credentials = "${file(local.credentials_file_path)}"
  project     = "${var.service_account_project}"
}

/******************************************
  Module service_account_iam_binding calling
 *****************************************/
module "service_account_iam_binding" {
  source = "../../"

  service_accounts = ["${var.service_account_one}", "${var.service_account_two}"]

  mode = "additive"

  bindings = {
    "roles/iam.serviceAccountKeyAdmin" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]

    "roles/iam.serviceAccountTokenCreator" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}
