resource "google_project_iam_audit_config" "project_iam_authoritative" {
  count   = length(audit_log_config)
  project = var.project
  service = audit_log_config[count.index].service 
  audit_log_config { 
    log_type         = audit_log_config[count.index].log_type
    exempted_members = audit_log_config[count.index].exempted_members
  }
}
