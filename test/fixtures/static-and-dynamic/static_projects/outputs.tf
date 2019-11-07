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

output "ids" {
  value       = local.static_project_ids
  description = "Projects created for bindings."

  depends_on = [
    # Projects must be created before the statically generated project_id
    # can be used in the IAM module
    google_project.test
  ]
}

output "mode" {
  value       = var.mode
  description = "Mode for adding the IAM policies/bindings, additive and authoritative"
}
