# Module Secure Source Manager Repository IAM

This submodule is used to assign roles on secure source manager repository.

## Example Usage
```
module "ssm_instance_iam_binding" {
  source    = "terraform-google-modules/iam/google//modules/secure_source_manager_repository_iam"
  version   = "~> 7.7"
  project   = var.project_id
  location  = "us-central1"

  repository_ids = [
    google_secure_source_manager_repository.default.repository_id,
  ]
  mode = "authoritative"

  bindings = {
    "roles/securesourcemanager.repoReader" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/roles/securesourcemanager.instanceRepositoryCreator" = [
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
| location | The location for the secure source manager Instance | `string` | n/a | yes |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |
| project | Project to add the IAM policies/bindings | `string` | n/a | yes |
| repository\_ids | List of secure source manager repositories | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| members | Members which were bound to the SSM instances. |
| repositories | Secure source manager repository names which received for bindings. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
