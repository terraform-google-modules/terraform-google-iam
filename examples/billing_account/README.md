# Billing Account Example

This example illustrates how to use the `billing_accounts_iam` submodule

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| billing\_account\_id | Billing Account ID to apply IAM bindings | string | n/a | yes |
| group\_email | Email for group to receive roles (ex. group@example.com) | string | n/a | yes |
| sa\_email | Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com) | string | n/a | yes |
| user\_email | Email for group to receive roles (Ex. user@example.com) | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

