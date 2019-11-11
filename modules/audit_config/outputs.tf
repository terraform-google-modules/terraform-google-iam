output "project" {
  value       = var.project
  description = "Project to add the IAM policies/bindings"
}

output "audit_log_config" {
  value       = local.audit_log_config
  description = "Map of log type and exempted members to be addded to service"
}