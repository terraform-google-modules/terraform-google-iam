/**
 * module `iam_role_multiplier`
 *
 * Input:
 *
 * - role_name       : Name of the role to repeat
 * - reference_count : Number of users or repeatitions
 *
 * Ouput:
 * - multiplied_roles: List of created custom roles
 * 
*/

locals {
  name_array     = split("/", var.role_name)
  base_role_name = element(local.name_array, length(local.name_array) - 1)
}

// Get permission from role to repeat
data "google_iam_role" "role" {
  name = var.role_name
}

// Create a custom role for each additional user
resource "google_project_iam_custom_role" "custom_role" {
  for_each    = { for i in range(var.reference_count) : i => i }
  role_id     = "${local.base_role_name}${each.value}"
  title       = "${local.base_role_name}${each.value}"
  permissions = data.google_iam_role.role.included_permissions

  lifecycle {
    create_before_destroy = true
  }
}
