locals {
  audit_log_config = distinct(flatten([
    for audit_log_x in var.audit_log_config:
      {  service = audit_log_x["service"], log_type = audit_log_x["log_type"], exempted_members = split("," , audit_log_x["exempted_members"]) }
  ]))
}

resource "google_project_iam_audit_config" "project_iam_authoritative" {
  count   = length(local.audit_log_config)
  project = var.project
  service = local.audit_log_config[count.index].service 
  audit_log_config { 
    log_type         = local.audit_log_config[count.index].log_type
    exempted_members = local.audit_log_config[count.index].exempted_members
  }
}
