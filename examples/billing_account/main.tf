/**
 * Copyright 2021 Google LLC
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
  service_account_01_email = "billing-iam-test-01@${var.project_id}.iam.gserviceaccount.com"
  service_account_02_email = "billing-iam-test-02@${var.project_id}.iam.gserviceaccount.com"

  bindings = {
    "roles/billing.viewer" = [
      "serviceAccount:${local.service_account_01_email}",
    ]

    "roles/billing.admin" = [
      "serviceAccount:${local.service_account_01_email}",
      "serviceAccount:${local.service_account_02_email}",
    ]
  }
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
