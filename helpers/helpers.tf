// IMPORTANT!!!
// To prevent duplication, this file MUST be a symbolic link
// to the original:
// $ ln -s ../../helpers/helpers.tf helpers.linked.tf

/******************************************
  Helpers
 ******************************************
 *
 * These helpers are an attempt to cover up for the lack of
 * preprocessing/templating functionality in terraform and keep the code
 * DRY even though we have to repeat it everywhere.
 *
 * Helpers are exactly the same across all modules.
 *
 * Arguments:
 *   var.mode
 *   var.bindings
 *   var.bindings_num
 *   local.entities
 *   local.entities_num
 */
locals {
  authoritative       = var.mode == "authoritative" ? 1 : 0
  additive            = var.mode == "additive" ? 1 : 0

  calculated_entities_num = (
    local.entities_num == 0
    ? length(local.entities)
    : local.entities_num
  )

  bindings_by_role    = distinct(flatten([
    for name in local.entities
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
