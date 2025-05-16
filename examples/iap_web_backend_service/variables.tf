variable "project_id" {
  type        = string
  description = "The project ID to host the backend service and apply IAM policies"
}

variable "group_email" {
  type        = string
  description = "Email for group to receive IAP roles (e.g., group@example.com)"
  default     = "iap_viewers_group@example.com"
}

variable "user_email" {
  type        = string
  description = "Email for user to receive IAP roles (e.g., user@example.com)"
  default     = "iap_user@example.com"
}

variable "web_backend_service_authoritative_names" {
  type        = list(string)
  description = "A list of existing web backend service names to apply authoritative IAM policies to."
  default     = ["iap-example-service"]
}

variable "web_backend_service_additive_names" {
  type        = list(string)
  description = "A list of existing web backend service names to apply additive IAM policies to."
  default     = ["iap-example-service"]
}
