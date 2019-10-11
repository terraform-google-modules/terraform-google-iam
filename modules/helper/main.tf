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
  authoritative = var.mode == "authoritative"
  additive      = var.mode == "additive"

  # When there are *_num specified, consider the module configuration
  # dynamic. In this case the `for_each` will basically work as
  # a polyfill for `count`
  #
  # The downside of the dynamic mode is that we can't guarantee the
  # resources being reused whenever the configuration changes.
  # Which leads to unnecessary resource recreations.
  dynamic = var.entities_num > 0 || var.bindings_num > 0

  calculated_entities_num = (
    var.entities_num > 0
    ? var.entities_num
    : length(var.entities)
  )

  bindings_by_role = distinct(flatten([
    for name in var.entities
    : [
      for role, members in var.bindings
      : { name = name, role = role, members = members }
    ]
  ]))

  bindings_by_member = distinct(flatten([
    for binding in local.bindings_by_role
    : [
      for member in binding["members"]
      : { name = binding["name"], role = binding["role"], member = member }
    ]
  ]))

  total_roles = (
    var.bindings_num > 0
    ? var.bindings_num * local.calculated_entities_num
    : length(local.bindings_by_role)
  )

  total_members = (
    var.bindings_num > 0
    ? var.bindings_num * local.calculated_entities_num
    : length(local.bindings_by_member)
  )

  keys_authoritative = (
    local.dynamic
    # [dynamic] fallback for_each to a simple list of indexes
    ? [for i in range(local.total_roles) : tostring(i)]
    # [static] generate unique ids which are resilient to updates
    : [
      for binding in local.bindings_by_role
      : "${binding["name"]}--${binding["role"]}"
    ]
  )

  keys_additive = (
    local.dynamic
    # [dynamic] fallback for_each to a simple list of indexes
    ? [for i in range(local.total_members) : tostring(i)]
    # [static] generate unique ids which are resilient to updates
    : [
      for binding in local.bindings_by_member
      : "${binding["name"]}--${binding["role"]}--${binding["member"]}"
    ]
  )

  bindings_authoritative = (
    local.authoritative
    ? zipmap(local.keys_authoritative, local.bindings_by_role)
    : {}
  )

  bindings_additive = (
    local.additive
    ? zipmap(local.keys_additive, local.bindings_by_member)
    : {}
  )

  # It is important to provide a set for the `for_each` instead of
  # the map, since we have to guarantee that the `for_each`
  # expression is resolved synchonously. And we have to workaround
  # the potential dependency on dynamic resource values by polyfilling
  # the `for_each` with `count`-like list of indexes.
  set_authoritative = (
    local.authoritative
    ? toset(local.keys_authoritative)
    : []
  )

  set_additive = (
    local.additive
    ? toset(local.keys_additive)
    : []
  )
}
