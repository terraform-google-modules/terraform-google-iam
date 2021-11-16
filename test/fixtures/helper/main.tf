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
  basic_roles               = ["roles/owner", "roles/editor"]
  org_roles                 = ["roles/owner", "roles/iam.organizationRoleViewer"]
  folder_roles              = ["roles/resourcemanager.folderViewer", "roles/resourcemanager.folderMover"]
  project_roles             = ["roles/iam.securityReviewer", "roles/iam.roleViewer"]
  project_conditional_roles = ["roles/compute.networkViewer", "roles/compute.networkUser"]
  bucket_roles              = ["roles/storage.legacyObjectReader", "roles/storage.legacyBucketReader"]
  members                   = [var.member1, var.member2]

  bindings_condition = {
    title       = "expires_after_2020_12_31"
    description = "Expiring at midnight of 2020-12-31"
    expression  = "request.time < timestamp(\"2021-01-01T00:00:00Z\")"
  }

  audit_log_config = [{
    service          = "storage.googleapis.com"
    log_type         = "DATA_READ"
    exempted_members = ["serviceAccount:${var.member1}"]
    }, {
    service          = "allServices"
    log_type         = "DATA_READ"
    exempted_members = ["serviceAccount:${var.member2}"]

  }]

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

  basic_bindings = zipmap(
    slice(local.basic_roles, 0, var.roles),
    slice(local.member_groups, 0, var.roles)
  )

  org_bindings = zipmap(
    slice(local.org_roles, 0, var.roles),
    slice(local.member_groups, 0, var.roles)
  )

  folder_bindings = zipmap(
    slice(local.folder_roles, 0, var.roles),
    slice(local.member_groups, 0, var.roles)
  )

  project_bindings = zipmap(
    slice(local.project_roles, 0, var.roles),
    slice(local.member_groups, 0, var.roles)
  )

  project_conditional_bindings = [
    merge(
      {
        role    = local.project_conditional_roles[0]
        members = local.member_group_0
      },
      local.bindings_condition
    ),
    merge(
      {
        role    = local.project_conditional_roles[1]
        members = local.member_group_1
      },
      local.bindings_condition
    )
  ]

  bucket_bindings = zipmap(
    slice(local.bucket_roles, 0, var.roles),
    slice(local.member_groups, 0, var.roles)
  )
}

module "base" {
  source               = "./base"
  base_billing_account = var.billing_account
  base_parent_id       = var.folder_id
  base_location        = var.location
  base_project_id      = var.project_id
  subnet_cidr          = var.subnet_cidr
}
