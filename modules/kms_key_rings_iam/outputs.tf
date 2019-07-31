/**
 * Copyright 2018 Google LLC
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

output "kms_key_rings" {
  value       = distinct(local.bindings_formated[*].kms_key_ring_name)
  description = "KMS key rings created for bindings."
}

output "kms_key_ring_roles" {
  value       = distinct(local.bindings_formated[*].role_name)
  description = "Roles to be assigned to kms_key_ring."
}

output "kms_key_ring_members" {
  value       = distinct(local.bindings_formated[*].member_id)
  description = "Members assigned to kms_key_ring."
}