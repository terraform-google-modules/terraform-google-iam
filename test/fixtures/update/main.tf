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
  static_n  = 2
  dynamic_n = 1 # Dynamic mode supports only 1 entity atm.
  mode      = "authoritative"
  prefix    = "test-iam"

  # TODO: Temporary. Have to change it manually after each destroy
  #       since project names stay reserved even after deletion.
  #       Used to test static IAM. We can get rid of it if
  #       we make a 2 step converge process with the var.random_hexes
  #       generation being the first step.
  uniqSuffix = "prj6"

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
    # Expectation is that no resource are gonna be recreated, but only
    # new ones added.
    # "roles/iam.securityReviewer" = local.member_group_0
  }
}

# Authoritative Static

module "authoritative_static_projects" {
  source          = "./static_projects"
  mode            = "authoritative"
  folder_id       = var.folder_id
  billing_account = var.billing_account
  random_hexes    = var.random_hexes
  prefix          = "${local.prefix}-${local.uniqSuffix}"
  n               = local.static_n
}

module "projects_iam_authoritative_static" {
  source   = "../../../modules/projects_iam"
  mode     = module.authoritative_static_projects.mode
  projects = module.authoritative_static_projects.ids
  bindings = local.project_bindings
}

# Additive Static

module "additive_static_projects" {
  source          = "./static_projects"
  mode            = "additive"
  folder_id       = var.folder_id
  billing_account = var.billing_account
  random_hexes    = var.random_hexes
  prefix          = "${local.prefix}-${local.uniqSuffix}"
  n               = local.static_n
}

module "projects_iam_additive_static" {
  source   = "../../../modules/projects_iam"
  mode     = module.authoritative_static_projects.mode
  projects = module.additive_static_projects.ids
  bindings = local.project_bindings
}

# Random ids for dynamic projects

resource "random_id" "test" {
  count       = local.dynamic_n
  byte_length = 2
}

# Authoritative Dynamic

resource "google_project" "authoritative_dynamic" {
  count = local.dynamic_n

  project_id      = "${local.prefix}-auth-dy-${count.index}-${random_id.test[count.index].hex}"
  folder_id       = var.folder_id
  name            = "Test IAM Project Auth Dy ${count.index}"
  billing_account = var.billing_account
}

module "projects_iam_authoritative_dynamic" {
  source       = "../../../modules/projects_iam"
  mode         = "authoritative"
  projects     = google_project.authoritative_dynamic[*].project_id
  bindings     = local.project_bindings
}

# Additive Dynamic

resource "google_project" "additive_dynamic" {
  count = local.dynamic_n

  project_id      = "${local.prefix}-add-dy-${count.index}-${random_id.test[count.index].hex}"
  folder_id       = var.folder_id
  name            = "Test IAM Project Add Dy ${count.index}"
  billing_account = var.billing_account
}

module "projects_iam_additive_dynamic" {
  source       = "../../../modules/projects_iam"
  mode         = "additive"
  projects     = google_project.additive_dynamic[*].project_id
  bindings     = local.project_bindings
}

# Providers

provider "google" {
  version = "~> 2.7"
}

provider "google-beta" {
  version = "~> 2.7"
}
