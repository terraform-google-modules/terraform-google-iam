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
    val.service => val...
  }
}

resource "google_project_iam_audit_config" "project" {
  for_each = local.audit_log_config
  project  = var.project
  service  = each.key

  dynamic "audit_log_config" {
    for_each = each.value
    iterator = log_type
    content {
      log_type         = log_type.value.log_type
      exempted_members = log_type.value.exempted_members
    }
  }
}
