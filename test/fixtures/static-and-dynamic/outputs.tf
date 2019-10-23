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

# Resources

output "authoritative_static_projects" {
  value       = module.authoritative_static_projects.ids
  description = "Projects created for bindings."
}

output "additive_static_projects" {
  value       = module.additive_static_projects.ids
  description = "Projects created for bindings."
}

output "authoritative_dynamic_projects" {
  value       = google_project.authoritative_dynamic[*].project_id
  description = "Projects created for bindings."
}

output "additive_dynamic_projects" {
  value       = google_project.additive_dynamic[*].project_id
  description = "Projects created for bindings."
}

# Binding Members

output "member_group_0" {
  value       = local.member_group_0
  description = "Members to be used in bindings."
}

output "member_group_1" {
  value       = local.member_group_1
  description = "Members to be used in bindings."
}

output "roles" {
  # workaround InSpec lack of support for integer
  value       = tostring(var.roles)
  description = "Amount of roles assigned. Useful for testing how the module behaves on updates."
}
