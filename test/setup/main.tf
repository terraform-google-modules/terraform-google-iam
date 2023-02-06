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

# Random folder name suffix

resource "random_id" "folder-rand" {
  byte_length = 2
}

resource "google_folder" "ci-iam-folder" {
  display_name = "ci-tests-iam-folder-${random_id.folder-rand.hex}"
  parent       = "folders/${var.folder_id}"
}

module "iam-project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 14.0"

  name                = "ci-iam"
  random_project_id   = true
  org_id              = var.org_id
  folder_id           = var.folder_id
  billing_account     = var.billing_account
  auto_create_network = true

  activate_apis = [
    "admin.googleapis.com",
    "appengine.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "oslogin.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudkms.googleapis.com",
    "pubsub.googleapis.com",
    "storage-api.googleapis.com",
    "servicenetworking.googleapis.com",
    "storage-component.googleapis.com",
    "iap.googleapis.com",
    "secretmanager.googleapis.com",
    "bigquery.googleapis.com",
    "dns.googleapis.com",
  ]
}

# Members

resource "google_service_account" "member" {
  count      = 2
  project    = module.iam-project.project_id
  account_id = "ci-iam-member-${count.index}-${random_id.folder-rand.hex}"
}

# Random id hex`es for static resources. Generate plenty of them just in case.

resource "random_id" "random_hexes" {
  count       = 15
  byte_length = 2
}
