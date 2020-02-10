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

locals {
  billing_roles = ["roles/billing.admin", "roles/billing.viewer"]
  members       = [var.member1, var.member2]

  member_group_0 = [
    "serviceAccount:${var.member1}",
    "serviceAccount:${var.member2}",
  ]

  member_group_1 = [
    "serviceAccount:${var.member2}",
  ]

  member_groups = [local.member_group_0, local.member_group_1]

  # 1 or 2 roles amount can be specified to generate that amount of bindings.
  # This variability is used to test how the module behaves on configuration updates.

  billing_bindings = zipmap(
    slice(local.billing_roles, 0, var.roles),
    slice(local.member_groups, 0, var.roles)
  )
}

provider "google" {
  version = "~> 2.7"
}

provider "google-beta" {
  version = "~> 2.7"
}

#additive

module "iam_binding_billing_accounts_additive" {
  source              = "../../../modules/billing_accounts_iam"
  mode                = "additive"
  bindings            = local.billing_bindings
  billing_account_ids = [var.billing_iam_test_account]
}
