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
  role_permissions = ["iam.roles.list", "iam.roles.create", "iam.roles.delete"]
}

resource "random_id" "rand_custom_id" {
  byte_length = 2
}

/******************************************
  Module custom_role call
 *****************************************/
module "custom-roles" {
  source = "../../modules/custom_role_iam/"

  role_level  = "project"
  org_id      = var.org_id
  project_id  = var.project_id
  role_id     = "custom_role_${random_id.rand_custom_id.hex}"
  title       = "Project_Custom_Role_${random_id.rand_custom_id.hex}"
  description = "Project level custom role"
  permissions = local.role_permissions
}
