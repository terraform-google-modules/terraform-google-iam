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

/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  version = "~> 2.7"
}

provider "google-beta" {
  version = "~> 2.7"
}

locals {

  bindings={
    "roles/billing.viewer" = [
      "serviceAccount:billing-iam-test-01@${var.project_id}.iam.gserviceaccount.com",
    ]

    "roles/billing.admin" = [
      "serviceAccount:billing-iam-test-01@${var.project_id}.iam.gserviceaccount.com",
      "serviceAccount:billing-iam-test-02@${var.project_id}.iam.gserviceaccount.com",
    ]
  }
}

resource "google_service_account" "service_account_01" {
  account_id = "billing-iam-test-01"
  project    = var.project_id
}

resource "google_service_account" "service_account_02" {
  account_id = "billing-iam-test-02"
  project    = var.project_id
}

/******************************************
  Module billing_account_iam_binding calling
 *****************************************/
module "billing-account-iam" {
  source = "../../modules/billing_accounts_iam/"

  billing_account_ids = [var.billing_account_id]

  mode = "additive"

  bindings = local.bindings
}
