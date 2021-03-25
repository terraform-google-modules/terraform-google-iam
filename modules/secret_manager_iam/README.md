# Module Secret Manager IAM

This optional module is used to assign secrets roles

## Usage

```hcl
module "secret_manager_iam" {
  source  = "terraform-google-modules/iam/google//modules/secret_manager_iam"
  project = "gcp-project-id"
  secrets = ["my-secret"]
  mode = "additive"

  bindings = {
    "roles/secretmanager.secretAccessor" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com"
    ]

    "roles/secretmanager.viewer" = [
      "user:my-user@my-org.com"
    ]
  }

  conditional_bindings = [
    {
      role = "roles/secretmanager.admin"
      title = "expires_after_2021_12_31"
      description = "Expiring at midnight of 2021-12-31"
      expression = "request.time < timestamp(\"2022-01-01T00:00:00Z\")"
      members = ["user:my-user@my-org.com"]
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(any)` | n/a | yes |
| conditional\_bindings | List of maps of role and respective conditions, and the members to add the IAM policies/bindings | <pre>list(object({<br>    role        = string<br>    title       = string<br>    description = string<br>    expression  = string<br>    members     = list(string)<br>  }))</pre> | `[]` | no |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |
| project | Project to add the IAM policies/bindings | `string` | `""` | no |
| secrets | Secret Manager Secrets list to add the IAM policies/bindings | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| members | Members which were bound to the Secret Manager Secrets. |
| roles | Roles which were assigned to members. |
| secrets | Secret Manager Secrets which received for bindings. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
