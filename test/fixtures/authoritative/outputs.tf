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

# Binding Roles

output "basic_roles" {
  value       = module.generic.basic_roles
  description = "Basic roles to be assigned to resources."
}

output "org_roles" {
  value       = module.generic.org_roles
  description = "Roles to be assigned to organizations."
}

output "folder_roles" {
  value       = module.generic.folder_roles
  description = "Roles to be assigned to folders."
}

output "project_roles" {
  value       = module.generic.project_roles
  description = "Roles to be assigned to projects."
}

output "project_conditional_roles" {
  value       = module.generic.project_conditional_roles
  description = "Roles to be assigned with conditions to projects."
}

output "bucket_roles" {
  value       = module.generic.bucket_roles
  description = "Roles to be assigned to buckets."
}

# Binding Members

output "member_group_0" {
  value       = module.generic.member_group_0
  description = "Members to be used in bindings."
}

output "member_group_1" {
  value       = module.generic.member_group_1
  description = "Members to be used in bindings."
}

# Binding Condition

output "bindings_condition" {
  value       = module.generic.bindings_condition
  description = "Condition to be used in conditional bindings."
}

# Resources

output "projects" {
  value       = module.generic.projects
  description = "Projects created for bindings."
}

output "folders" {
  value       = module.generic.folders
  description = "Folders created for bindings."
}

output "subnets" {
  value       = module.generic.subnets
  description = "Subnetworks created for bindings."
}

output "region" {
  value       = module.generic.region
  description = "Created Subnetworks region."
}

output "service_accounts" {
  value       = module.generic.service_accounts
  description = "Service accounts created for bindings."
}

output "members" {
  value       = module.generic.members
  description = "Members created for binding with roles."
}

output "buckets" {
  value       = module.generic.buckets
  description = "Storage buckets created for bindings."
}

output "key_rings" {
  value       = module.generic.key_rings
  description = "Key rings created for bindings."
}

output "keys" {
  value       = module.generic.keys
  description = "Crypto keys created for bindings."
}

output "topics" {
  value       = module.generic.topics
  description = "Pubsub topics created for bindings."
}

output "subscriptions" {
  value       = module.generic.subscriptions
  description = "Pubsub subscriptions created for bindings."
}

output "project_id" {
  value       = module.generic.project_id
  description = "Project ID of the test fixture project. Used to avoid timing issues with recently created projects."
}

output "roles" {
  # workaround InSpec lack of support for integer
  value       = tostring(var.roles)
  description = "Amount of roles assigned. Useful for testing how the module behaves on updates."
}

output "audit_config" {
  value       = module.generic.audit_config
  description = "Map of log type and exempted members to be addded to service"
}

output "secrets" {
  value       = module.generic.secrets
  description = "Secrets created for bindings."
}
