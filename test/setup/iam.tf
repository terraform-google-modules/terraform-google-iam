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
  int_required_proj_roles = [
    "roles/owner",
    "roles/resourcemanager.projectIamAdmin",
    "roles/iam.serviceAccountAdmin",
    "roles/compute.admin",
    "roles/compute.networkAdmin",
    "roles/compute.storageAdmin",
    "roles/pubsub.admin",
    "roles/cloudkms.admin",
    "roles/storage.admin",
    "roles/composer.worker",
  ]

  int_required_folder_roles = [
    "roles/resourcemanager.projectCreator",
    "roles/resourcemanager.folderAdmin",
    "roles/resourcemanager.folderIamAdmin",
    "roles/owner",
    "roles/billing.projectManager",
    "roles/composer.worker",
  ]

  int_required_ba_roles = [
    "roles/billing.user",
  ]
}

resource "google_service_account" "int_test" {
  project      = module.iam-project.project_id
  account_id   = "iam-int-test"
  display_name = "iam-int-test"
}

resource "google_project_iam_member" "int_test_project" {
  count = length(local.int_required_proj_roles)

  project = module.iam-project.project_id
  role    = local.int_required_proj_roles[count.index]
  member  = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_folder_iam_member" "int_test_folder" {
  count = length(local.int_required_folder_roles)

  folder = google_folder.ci-iam-folder.name
  role   = local.int_required_folder_roles[count.index]
  member = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_billing_account_iam_member" "int_test_ba" {
  count = length(local.int_required_ba_roles)

  billing_account_id = var.billing_account
  role               = local.int_required_ba_roles[count.index]
  member             = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_service_account_key" "int_test" {
  service_account_id = google_service_account.int_test.id
}
