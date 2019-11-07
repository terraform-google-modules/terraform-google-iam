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

output "bindings_by_member" {
  value       = local.bindings_by_member
  description = "List of bindings for entities unwinded by members."
}

output "set_authoritative" {
  value       = local.set_authoritative
  description = "A set of authoritative binding keys (from bindings_authoritative) to be used in for_each. Unwinded by roles."
}

output "set_additive" {
  value       = local.set_additive
  description = "A set of additive binding keys (from bindings_additive) to be used in for_each. Unwinded by members."
}

output "bindings_authoritative" {
  value       = local.bindings_authoritative
  description = "Map of authoritative bindings for entities. Unwinded by roles."
}

output "bindings_additive" {
  value       = local.bindings_additive
  description = "Map of additive bindings for entities. Unwinded by members."
}
