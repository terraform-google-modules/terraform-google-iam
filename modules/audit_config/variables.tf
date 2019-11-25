variable "service" {
  description = "Service which will be enabled for audit logging" 
  type        = string
  default     = "allServices"
}

variable "audit_log_config" {
  description = "List of objects to be added to audit log config"
  type        = list(object({service: string, log_type: string, exempted_members: list(string)))
}

variable "project" {
  description = "Project to add the IAM policies/bindings"
  type        = string
}
