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

output "project_id" {
  value       = var.project_id
  description = "Project ID of the Custom Role."
}

output "org_id" {
  value       = var.org_id
  description = "Organization ID of the Custom Role."
}

output "custom_role_id_project" {
  value       = module.create_custom_role_project.role_id
  description = "ID of the custom role created at project level."
}

output "custom_role_id_org" {
  value       = module.create_custom_role_org.role_id
  description = "ID of the custom role created at organization level."
}

output "custom_role_id_org_unsupported" {
  value       = module.create_custom_role_unsupported_permissions_org.custom_role_id
  description = "ID of the custom role created formed from base role with unsupported permissions"
}
