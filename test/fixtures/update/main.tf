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

  project_bindings = {
    "roles/iam.roleViewer" = local.member_group_0

    # Uncommenting only one additional role below will force
    # recreation of resources because of the change in list indexes
    #
    # before:
    #   - iam[0] - project0 role0
    #   - iam[1] - project1 role0
    #
    # after:
    #   - iam[0] - project0 role0
    #   - iam[1] - project0 role1 <-- this resource is being modified instead of just reusing it as an item iam[2] below:
    #   - iam[2] - project1 role0 <-- this resource is created from scratch, even though it did exist before
    #   - iam[3] - project1 role1

    # "roles/logging.viewer" = local.member_group_0

    # More roles to test:

    # "roles/iam.securityReviewer" = local.member_group_0
  }
}

resource "random_id" "test" {
  count = local.n

  byte_length = 2
}

resource "google_project" "test" {
  count = local.n

  project_id      = "${local.prefix}-prj-${count.index}-${random_id.test[count.index].hex}"
  folder_id       = var.folder_id
  name            = "Test IAM Project ${count.index}"
  billing_account = var.billing_account
}

module "iam_binding_project" {
  source       = "../../../modules/projects_iam"
  mode         = local.mode
  projects     = google_project.test.*.project_id
  projects_num = length(google_project.test.*.project_id)
  bindings     = local.project_bindings
  bindings_num = length(local.project_bindings)
}

provider "google" {
  version = "~> 2.7"
}

provider "google-beta" {
  version = "~> 2.7"
}
