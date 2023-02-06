/**
 * Copyright 2023 Google LLC
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

module "create_custom_role_project" {
  source     = "../../../examples/custom_role_project"
  project_id = var.project_id
}

module "create_custom_role_org" {
  source = "../../../examples/custom_role_org"
  org_id = var.org_id
}

module "create_custom_role_unsupported_permissions_org" {
  source       = "../../../modules/custom_role_iam"
  target_level = "org"
  target_id    = var.org_id
  role_id      = "customDatastoreViewer_${random_id.rand_custom_id.hex}"
  base_roles   = ["roles/gkehub.viewer"] # https://cloud.google.com/iam/docs/custom-roles-permissions-support
  permissions  = []
  members      = []
}

resource "random_id" "rand_custom_id" {
  byte_length = 2
}
