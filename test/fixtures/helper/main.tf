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

# This helper module is used multiple times to run multiple kitchen test suites

locals {
  basic_roles   = ["roles/owner", "roles/editor"]
  org_roles     = ["roles/owner", "roles/iam.organizationRoleViewer"]
  folder_roles  = ["roles/resourcemanager.folderViewer", "roles/resourcemanager.folderMover"]
  project_roles = ["roles/iam.securityReviewer", "roles/iam.roleViewer"]
  bucket_roles  = ["roles/storage.legacyObjectReader", "roles/storage.legacyBucketReader"]
  members       = [var.member1, var.member2]

  member_group_0 = [
    "serviceAccount:${var.member1}",
    "serviceAccount:${var.member2}",
  ]

  member_group_1 = [
    "serviceAccount:${var.member2}",
  ]

  basic_bindings = "${map(
    local.basic_roles[0], local.member_group_0,
    local.basic_roles[1], local.member_group_1,
  )}"

  org_bindings = "${map(
    local.org_roles[0], local.member_group_0,
    local.org_roles[1], local.member_group_1,
  )}"

  folder_bindings = "${map(
    local.folder_roles[0], local.member_group_0,
    local.folder_roles[1], local.member_group_1,
  )}"

  project_bindings = "${map(
    local.project_roles[0], local.member_group_0,
    local.project_roles[1], local.member_group_1,
  )}"

  bucket_bindings = "${map(
    local.bucket_roles[0], local.member_group_0,
    local.bucket_roles[1], local.member_group_1,
  )}"

}

provider "google" {
  version = "~> 2.7"
}

provider "google-beta" {
  version = "~> 2.7"
}

module "base" {
  source               = "./base"
  base_billing_account = var.billing_account
  base_parent_id       = var.folder_id
  base_location        = var.location
  base_project_id      = var.project_id
  subnet_cidr          = var.subnet_cidr
}
