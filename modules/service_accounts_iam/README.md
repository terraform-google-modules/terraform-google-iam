# Module service_account IAM

This optional module is used to assign service_account roles

## Example Usage
```
module "service_account-iam-bindings" {
  source = "terraform-google-modules/iam/google//modules/service_accounts_iam"

  service_accounts = ["my-service_account_one", "my-service_account_two"]
  project          = "my-service_account_project"
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
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | map(list(string)) | n/a | yes |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | string | `"additive"` | no |
| project | Project to add the IAM policies/bindings | string | `""` | no |
| service\_accounts | Service Accounts list to add the IAM policies/bindings | list(string) | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| members | Members which were bound to the Service Account. |
| roles | Roles which were assigned to members. |
| service\_accounts | Service Accounts which received bindings. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
