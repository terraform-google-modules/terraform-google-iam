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

resource "google_service_account" "member_iam_test" {
  project      = var.project_id
  account_id   = "member-iam-test"
  display_name = "member-iam-test"
}

module "member_roles" {
  source                  = "../../modules/member_iam"
  service_account_address = google_service_account.member_iam_test.email
  project_id              = var.project_id
  project_roles           = ["roles/compute.networkAdmin", "roles/appengine.appAdmin"]
  prefix                  = "serviceAccount"
}
