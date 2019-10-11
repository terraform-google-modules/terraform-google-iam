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
  n           = 2
  mode        = "authoritative"
  prefix      = "test-iam"

  member_group_0 = [
    "serviceAccount:${var.member1}",
  ]

  member_group_1 = [
    "serviceAccount:${var.member1}",
    "serviceAccount:${var.member2}"
  ]

  project_bindings = {
    "roles/iam.roleViewer" = local.member_group_0
    "roles/logging.viewer" = local.member_group_1

    # Uncomment the following role and re`converge` to test
    # whether some resources were recreated.
    # For `static` only new resources should be added.
    # For `dynamic` some resources will be forced to be recreated.
    # "roles/iam.securityReviewer" = local.member_group_0
  }
}

# Authoritative Static

locals {
  authoritative_static_project_ids = [
    for i in range(local.n)
    : "${local.prefix}-prj2-auth-st-${i}-${var.random_hexes[i]}"
  ]
}

resource "google_project" "authoritative_static" {
  count = local.n

  project_id      = local.authoritative_static_project_ids[count.index]
  folder_id       = var.folder_id
  name            = "Test IAM Project Auth St ${count.index}"
  billing_account = var.billing_account
}

module "projects_iam_authoritative_static" {
  source   = "../../../modules/projects_iam"
  mode     = "authoritative"
  projects = local.authoritative_static_project_ids
  bindings = local.project_bindings
}

# Additive Static

locals {
  additive_static_project_ids = [
    for i in range(local.n)
    : "${local.prefix}-prj2-add-st-${i}-${var.random_hexes[i]}"
  ]
}

resource "google_project" "additive_static" {
  count = local.n

  project_id      = local.additive_static_project_ids[count.index]
  folder_id       = var.folder_id
  name            = "Test IAM Project Add St ${count.index}"
  billing_account = var.billing_account
}

module "projects_iam_additive_static" {
  source   = "../../../modules/projects_iam"
  mode     = "additive"
  projects = local.additive_static_project_ids
  bindings = local.project_bindings
}

# Authoritative Dynamic

resource "google_project" "authoritative_dynamic" {
  count = local.n

  project_id      = "${local.prefix}-prj2-auth-dy-${count.index}-${var.random_hexes[count.index]}"
  folder_id       = var.folder_id
  name            = "Test IAM Project Auth Dy ${count.index}"
  billing_account = var.billing_account
}

module "projects_iam_authoritative_dynamic" {
  source       = "../../../modules/projects_iam"
  mode         = "authoritative"
  projects     = google_project.authoritative_dynamic[*].project_id
  bindings     = local.project_bindings
  projects_num = length(google_project.authoritative_dynamic[*].project_id)
  bindings_num = length(local.project_bindings)
}

# Additive Dynamic

resource "google_project" "additive_dynamic" {
  count = local.n

  project_id      = "${local.prefix}-prj2-add-dy-${count.index}-${var.random_hexes[count.index]}"
  folder_id       = var.folder_id
  name            = "Test IAM Project Add Dy ${count.index}"
  billing_account = var.billing_account
}

module "projects_iam_additive_dynamic" {
  source       = "../../../modules/projects_iam"
  mode         = "additive"
  projects     = google_project.additive_dynamic[*].project_id
  bindings     = local.project_bindings
  projects_num = length(google_project.additive_dynamic[*].project_id)

  bindings_num = length(flatten([
    for role, members in local.project_bindings
    : [for member in members : true]
  ]))
}

# Providers

provider "google" {
  version = "~> 2.7"
}

provider "google-beta" {
  version = "~> 2.7"
}
