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

output "credentials_file_path" {
  value       = "${path.module}/${var.credentials_file_path}"
  description = "Path to google credentials file."
}

# Binding Roles

output "basic_roles" {
  value       = "${local.basic_roles}"
  description = "Basic roles to be assigned to resources."
}

output "org_roles" {
  value       = "${local.org_roles}"
  description = "Roles to be assigned to organizations."
}

output "project_roles" {
  value       = "${local.project_roles}"
  description = "Roles to be assigned to projects."
}

output "bucket_roles" {
  value       = "${local.bucket_roles}"
  description = "Roles to be assigned to buckets."
}

# Binding Members

output "member_group_0" {
  value       = "${local.member_group_0}"
  description = "Members to be used in bindings."
}

output "member_group_1" {
  value       = "${local.member_group_1}"
  description = "Members to be used in bindings."
}

# Resources

output "projects" {
  value       = "${module.base.projects}"
  description = "Projects created for bindings."
}

output "folders" {
  value       = "${module.base.folders}"
  description = "Folders created for bindings."
}

output "subnets" {
  value       = "${local.subnets}"
  description = "Subnetworks created for bindings."
}

output "service_accounts" {
  value       = "${module.base.service_accounts}"
  description = "Service accounts created for bindings."
}

output "members" {
  value       = "${module.base.members}"
  description = "Members created for binding with roles."
}

output "buckets" {
  value       = "${module.base.buckets}"
  description = "Storage buckets created for bindings."
}

output "key_rings" {
  value       = "${module.base.key_rings}"
  description = "Key rings created for bindings."
}

output "keys" {
  value       = "${module.base.keys}"
  description = "Crypto keys created for bindings."
}

output "topics" {
  value       = "${module.base.topics}"
  description = "Pubsub topics created for bindings."
}

output "subscriptions" {
  value       = "${module.base.subscriptions}"
  description = "Pubsub subscriptions created for bindings."
}
