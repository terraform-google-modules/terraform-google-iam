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

  # When there is only one entity, consider that the entity passed
  # might be dynamic. In this case the `for_each` will not use
  # entity name when constructing the unique ID.
  #
  # Other rules regrading the dynamic nature of resources:
  # 1. The roles might never be dynamic.
  # 2. Members might only be dynamic in `authoritative` mode.
  singular = length(var.entities) <= 1

  # In singular mode, replace entity name with a constant "default". This
  # will prevent the potentially dynamic resource name usage in the `for_each`
  aliased_entities = local.singular ? ["default"] : var.entities

  # Cover the usecase of specifying singular entity instead of an array
  real_entities = var.entity != "" ? [var.entity] : var.entities

  bindings_by_role = distinct(flatten([
    for name in local.real_entities
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

  keys_authoritative = distinct(flatten([
    for alias in local.aliased_entities
    : [
      for role in keys(var.bindings)
      : "${alias}--${role}"
    ]
  ]))

  keys_additive = distinct(flatten([
    for alias in local.aliased_entities
    : [
      for role, members in var.bindings
      : [
        for member in members
        : "${alias}--${role}--${member}"
      ]
    ]
  ]))

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
  # expression is resolved synchonously.
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
