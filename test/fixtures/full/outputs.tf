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
  value = "${path.module}/${var.credentials_file_path}"
}

# Binding Roles

output "basic_roles" {
  value = ["${local.basic_roles}"]
}

output "org_roles" {
  value = ["${local.org_roles}"]
}

output "project_roles" {
  value = ["${local.project_roles}"]
}

output "bucket_roles" {
  value = ["${local.bucket_roles}"]
}

# Binding Members

output "member_group_0" {
  value = ["${local.member_group_0}"]
}

output "member_group_1" {
  value = ["${local.member_group_1}"]
}

# Resources

output "projects" {
  value = ["${module.base.projects}"]
}

output "folders" {
  value = ["${module.base.folders}"]
}

output "subnets" {
  value = ["${local.subnets}"]
}

output "service_accounts" {
  value = ["${module.base.service_accounts}"]
}

output "members" {
  value = ["${module.base.members}"]
}

output "buckets" {
  value = ["${module.base.buckets}"]
}

output "key_rings" {
  value = ["${module.base.key_rings}"]
}

output "keys" {
  value = ["${module.base.keys}"]
}

output "topics" {
  value = ["${module.base.topics}"]
}

output "subscriptions" {
  value = ["${module.base.subscriptions}"]
}
