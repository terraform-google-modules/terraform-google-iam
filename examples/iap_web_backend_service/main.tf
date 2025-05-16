module "iap_web_backend_service_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/iap_web_backend_services_iam"
  version = "~> 8.0"

  project              = var.project_id
  web_backend_services = var.web_backend_service_additive_names
  mode                 = "additive"

  bindings = {
    "roles/iap.httpsResourceAccessor" = [
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }

  conditional_bindings = [
    {
      role        = "roles/iap.httpsResourceAccessor"
      title       = "expires_after_2025_12_31"
      description = "Expiring at midnight of 2025-12-31"
      expression  = "request.time < timestamp(\"2026-01-01T00:00:00Z\")"
      members     = ["group:${var.group_email}"]
    }
  ]
}

module "iap_web_backend_service_iam_bindings_authoritative" {
  source  = "terraform-google-modules/iam/google//modules/iap_web_backend_services_iam"
  version = "~> 8.0"

  project              = var.project_id
  web_backend_services = var.web_backend_service_authoritative_names
  mode                 = "authoritative"

  bindings = {
    "roles/iap.httpsResourceAccessor" = [
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }

  conditional_bindings = [
    {
      role        = "roles/iap.httpsResourceAccessor"
      title       = "expires_after_2025_12_31"
      description = "Expiring at midnight of 2025-12-31"
      expression  = "request.time < timestamp(\"2026-01-01T00:00:00Z\")"
      members     = ["group:${var.group_email}"]
    }
  ]
}
