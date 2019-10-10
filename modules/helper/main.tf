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
  # dynamic. In this case the `count`-resources will be used instead
  # of the `for_each`-resources
  #
  # The downside of depending on `count` is that we can't guarantee the
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

  for_each_authoritative = (
    !local.dynamic && local.authoritative
    ? zipmap([
      for binding in local.bindings_by_role
      : "${binding["name"]}--${binding["role"]}"
    ], local.bindings_by_role)
    : {}
  )

  for_each_additive = (
    !local.dynamic && local.additive
    ? zipmap([
      for binding in local.bindings_by_member
      : "${binding["name"]}--${binding["role"]}--${binding["member"]}"
    ], local.bindings_by_member)
    : {}
  )

  count_authoritative = (
    local.dynamic && local.authoritative
    ? (
      var.bindings_num > 0
      ? var.bindings_num * local.calculated_entities_num
      : length(local.bindings_by_role)
    )
    : 0
  )

  count_additive = (
    local.dynamic && local.additive
    ? (
      var.bindings_num > 0
      ? var.bindings_num * local.calculated_entities_num
      : length(local.bindings_by_member)
    )
    : 0
  )
}
