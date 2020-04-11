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
  audit_log_config = {
    for key, val in var.audit_log_config :
    key => val
  }
}

resource "google_project_iam_audit_config" "project" {
  for_each = local.audit_log_config
  project  = var.project
  service  = each.value.service
  audit_log_config {
    log_type         = each.value.log_type
    exempted_members = each.value.exempted_members
  }
}
