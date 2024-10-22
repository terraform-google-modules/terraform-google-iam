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

output "custom_role_id" {
  value       = local.custom-role-output
  description = "ID of the custom role created."
}

output "custom_role_name" {
  value       = (var.target_level == "project") ? google_project_iam_custom_role.project-custom-role[0].name : google_organization_iam_custom_role.org-custom-role[0].name
  description = "Name of the custom role created in the format {{target_level}}/{{target_id}}/roles/{{role_id}}, for use as a reference in other resources such as IAM role bindings."
}
