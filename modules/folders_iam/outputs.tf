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

output "folders" {
  value       = distinct(local.bindings_formatted[*].folder_name)
  description = "Folders which received bindings."
}

output "roles" {
  value       = distinct(local.bindings_formatted[*].role_name)
  description = "Roles which were assigned to members."
}

output "members" {
  value       = distinct(local.bindings_formatted[*].member_id)
  description = "Members which were bound to the folders."
}
