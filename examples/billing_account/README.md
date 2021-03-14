# Billing Account Example

This example illustrates how to use the `billing_accounts_iam` submodule

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_account\_id | Billing Account ID to apply IAM bindings | `string` | n/a | yes |
| project\_id | Project ID for the module | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| billing\_account\_ids | Billing Accounts which received bindings. |
| members | Members which were bound to the billing accounts. |
| service\_account\_addresses | Service Account Addresses which were bound to projects. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

