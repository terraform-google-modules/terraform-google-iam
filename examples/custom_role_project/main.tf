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

/******************************************
  Module custom_role call
 *****************************************/
module "custom-role-project" {
  source = "../../modules/custom_role_iam/"

  target_level         = "project"
  target_id            = var.project_id
  role_id              = "iamDeleter"
  base_roles           = ["roles/iam.serviceAccountAdmin"]
  permissions          = ["iam.roles.list", "iam.roles.create", "iam.roles.delete"]
  excluded_permissions = ["iam.serviceAccounts.setIamPolicy", "resourcemanager.projects.get", "resourcemanager.projects.list"]
  description          = "This is a project level custom role."
  members              = ["serviceAccount:custom-role-account-01@${var.project_id}.iam.gserviceaccount.com", "serviceAccount:custom-role-account-02@${var.project_id}.iam.gserviceaccount.com"]
}

/******************************************
  Create service accounts to use as members
 *****************************************/
resource "google_service_account" "custom_role_account_01" {
  account_id = "custom-role-account-01"
  project    = var.project_id
}

resource "google_service_account" "custom_role_account_02" {
  account_id = "custom-role-account-02"
  project    = var.project_id
}
