output "web_backend_services" {
  value       = distinct(module.helper.bindings_by_member[*].name)
  description = "IAP Web Backend Services which received bindings."
  depends_on = [
    google_iap_web_backend_service_iam_binding.iap_web_backend_service_iam_authoritative,
    google_iap_web_backend_service_iam_member.iap_web_backend_service_iam_additive
  ]
}

output "roles" {
  value       = distinct(module.helper.bindings_by_member[*].role)
  description = "Roles which were assigned to members."
  depends_on = [
    google_iap_web_backend_service_iam_binding.iap_web_backend_service_iam_authoritative,
    google_iap_web_backend_service_iam_member.iap_web_backend_service_iam_additive
  ]
}

output "members" {
  value       = distinct(module.helper.bindings_by_member[*].member)
  description = "Members who were bound to the IAP Web Backend Services."
  depends_on = [
    google_iap_web_backend_service_iam_binding.iap_web_backend_service_iam_authoritative,
    google_iap_web_backend_service_iam_member.iap_web_backend_service_iam_additive
  ]
}
