/******************************************
  Run helper module to get generic calculated data
 *****************************************/
module "helper" {
  source               = "../helper"
  bindings             = var.bindings
  mode                 = var.mode
  entities             = var.web_backend_services
  conditional_bindings = var.conditional_bindings
}


/******************************************
  IAP Web Backend IAM binding authoritative
 *****************************************/
resource "google_iap_web_backend_service_iam_binding" "iap_web_backend_service_iam_authoritative" {
  for_each = module.helper.set_authoritative

  project             = var.project
  web_backend_service = module.helper.bindings_authoritative[each.key].name
  role                = module.helper.bindings_authoritative[each.key].role
  members             = module.helper.bindings_authoritative[each.key].members

  dynamic "condition" {
    for_each = module.helper.bindings_authoritative[each.key].condition.title == "" ? [] : [module.helper.bindings_authoritative[each.key].condition]
    content {
      title       = condition.value.title
      description = condition.value.description
      expression  = condition.value.expression
    }
  }
}

/******************************************
  IAP Web Backend IAM binding additive
 *****************************************/
resource "google_iap_web_backend_service_iam_member" "iap_web_backend_service_iam_additive" {
  for_each = module.helper.set_additive

  project             = var.project
  web_backend_service = module.helper.bindings_additive[each.key].name
  role                = module.helper.bindings_additive[each.key].role
  member              = module.helper.bindings_additive[each.key].member

  dynamic "condition" {
    for_each = module.helper.bindings_additive[each.key].condition.title == "" ? [] : [module.helper.bindings_additive[each.key].condition]
    content {
      title       = condition.value.title
      description = condition.value.description
      expression  = condition.value.expression
    }
  }
}
