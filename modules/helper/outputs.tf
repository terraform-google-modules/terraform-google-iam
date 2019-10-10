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

output "bindings_by_role" {
  value       = local.bindings_by_role
  description = "List of bindings for entities unwinded by roles."
}

output "bindings_by_member" {
  value       = local.bindings_by_member
  description = "List of bindings for entities unwinded by members."
}

output "for_each_authoritative" {
  value       = local.for_each_authoritative
  description = "Map of bindings for entities unwinded by roles."
}

output "for_each_additive" {
  value       = local.for_each_additive
  description = "Map of bindings for entities unwinded by members."
}

output "count_authoritative" {
  value       = local.count_authoritative
  description = "Count of authoritative iam rules to apply. 0 for non-authoritative mode."
}

output "count_additive" {
  value       = local.count_additive
  description = "Count of additive iam rules to apply. 0 for non-additive mode."
}
