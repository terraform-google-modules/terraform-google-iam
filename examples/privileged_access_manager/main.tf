/**
 * Copyright 2024 Google LLC
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

module "entitlement" {
  source  = "terraform-google-modules/iam/google//modules/privileged_access_manager"
  version = "~> 8.0"

  entitlement_id = "example-entitlement"
  parent_id      = var.project_id
  parent_type    = "project"
  entitlement_requesters = [
    "user:requester@example.com",
  ]
  entitlement_approvers = [
    "user:approver@example.com",
  ]
  role_bindings = [
    {
      role                 = "roles/storage.admin"
      condition_expression = "request.time < timestamp(\"2024-04-23T18:30:00.000Z\")"
    },
    {
      role = "roles/bigquery.admin"
    }
  ]
}
