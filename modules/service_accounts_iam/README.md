# Module service_account IAM

This optional module is used to assign service_account roles

## Example Usage
```
resource "google_service_account" "service_account_one" {
  account_id   = "my-service_account_one"
  display_name = "my service account one"
  project      = "<PROJECT ID>"
}

module "service_account-iam-bindings" {
  source = "terraform-google-modules/iam/google//modules/service_accounts_iam"

  service_accounts = [google_service_account.service_account_one.email]
  project          = "<PROJECT ID>"
  mode             = "additive"
  bindings = {
    "roles/iam.serviceAccountKeyAdmin" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com",
      "user:my-user@my-org.com",
    ]

    "roles/iam.serviceAccountTokenCreator" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com",
      "user:my-user@my-org.com",
    ]
  }
  conditional_bindings = [
    {
      role = "roles/iam.serviceAccountUser"
      title = "expires_after_2019_12_31"
      description = "Expiring at midnight of 2019-12-31"
      expression = "request.time < timestamp(\"2020-01-01T00:00:00Z\")"
      members = ["user:my-user@my-org.com"]
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(list(string))` | `{}` | no |
| conditional\_bindings | List of maps of role and respective conditions, and the members to add the IAM policies/bindings | <pre>list(object({<br>    role        = string<br>    title       = string<br>    description = string<br>    expression  = string<br>    members     = list(string)<br>  }))</pre> | `[]` | no |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |
| project | Project to add the IAM policies/bindings | `string` | `""` | no |
| service\_accounts | Service Accounts Email list to add the IAM policies/bindings | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| members | Members which were bound to the Service Account. |
| roles | Roles which were assigned to members. |
| service\_accounts | Service Accounts which received bindings. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
