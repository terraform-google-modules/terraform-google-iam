# Module Billing Accounts IAM

This optional module is used to assign Billing Accounts roles

## Usage

```hcl
module "billing-account-iam" {
  source  = "terraform-google-modules/iam/google//modules/billing_accounts_iam"
  billing_account_ids = ["035617-1B8VBC-AF0TD9"]

  mode = "additive"

  bindings = {
    "roles/billing.viewer" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com",
    ]

    "roles/billing.user" = [
      "user:my-user@my-org.com",
    ]
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_account\_ids | Billing Accounts IDs list to add the IAM policies/bindings | `list(string)` | `[]` | no |
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(list(string))` | n/a | yes |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |

## Outputs

| Name | Description |
|------|-------------|
| billing\_account\_ids | Billing Accounts which received bindings. |
| members | Members which were bound to the billing accounts. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
