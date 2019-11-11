variable "service" {
  description = "Service which will be enabled for audit logging" 
  type        = string
  default     = "allServices"
}

variable "audit_log_config" {
  description = "Map of log type and exempted members to be addded to service"
  type        = list(map(string))
}

variable "project" {
  description = "Project to add the IAM policies/bindings"
  default     = ""
  type        = string
}
