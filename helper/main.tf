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

locals {
  authoritative       = var.mode == "authoritative" ? 1 : 0
  additive            = var.mode == "additive" ? 1 : 0

  calculated_entities_num = (
    var.entities_num == 0
    ? length(var.entities)
    : var.entities_num
  )

  bindings_by_role    = distinct(flatten([
    for name in var.entities
    : [
      for role, members in var.bindings
      : { name = name, role = role, members = members }
    ]
  ]))

  bindings_by_member  = distinct(flatten([
    for binding in local.bindings_by_role
    : [
      for member in binding["members"]
      : { name = binding["name"], role = binding["role"], member = member }
    ]
  ]))

  count_authoritative = local.authoritative * (
    var.bindings_num > 0
    ? var.bindings_num * local.calculated_entities_num
    : length(local.bindings_by_role)
  )

  count_additive      = local.additive * (
    var.bindings_num > 0
    ? var.bindings_num * local.calculated_entities_num
    : length(local.bindings_by_member)
  )
}
