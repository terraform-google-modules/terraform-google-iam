# Module Secure Source Manager Instance IAM

This submodule is used to assign roles on secure source manager instance.

## Example Usage
```
module "ssm_instance_iam_binding" {
  source    = "terraform-google-modules/iam/google//modules/secure_source_manager_instance_iam"
  version   = "~> 8.0"

  project   = var.project_id
  location  = "us-central1"

  instance_ids = [
    google_secure_source_manager_instance.default.instance_id,
  ]
  mode = "additive"

  bindings = {
    "roles/securesourcemanager.instanceAccessor" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/securesourcemanager.instanceManager" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(any)` | n/a | yes |
| entity\_ids | List of secure source manager instance or repository names | <pre>object({<br>    instance_ids   = optional(list(string))<br>    repository_ids = optional(list(string))<br>  })</pre> | n/a | yes |
| location | The location for the secure source manager Instance | `string` | n/a | yes |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |
| project | Project to add the IAM policies/bindings | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instances | Secure source manager instance names which received for bindings. |
| members | Members which were bound to the SSM instances. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
