variable "project" {
  description = "Project ID where the IAP Web Backend Services are located."
  type        = string
  default     = null
}

variable "web_backend_services" {
  description = "List of IAP Web Backend Service names to add IAM policies/bindings to."
  type        = list(string)
  default     = []
}

variable "mode" {
  description = "Mode for adding IAM policies/bindings. Valid values are 'additive' or 'authoritative'."
  type        = string
  default     = "additive"

  validation {
    condition     = contains(["additive", "authoritative"], var.mode)
    error_message = "Mode must be one of 'additive' or 'authoritative'."
  }
}

variable "bindings" {
  description = "Map of role (key) and list of members (value) to add the IAM policies/bindings."
  type        = map(list(string))
  default     = {}
}

variable "conditional_bindings" {
  description = "List of maps of role, condition, and members to add the IAM policies/bindings."
  type = list(object({
    role        = string
    title       = string
    description = optional(string)
    expression  = string
    members     = list(string)
  }))
  default = []
}
