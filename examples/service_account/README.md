# Service Account Example

This example illustrates how to use the `service_accounts_iam` submodule

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| credentials\_file\_path | Path to the service account | `any` | n/a | yes |
| group\_email | Email for group to receive roles (ex. group@example.com) | `string` | n/a | yes |
| sa\_email | Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com) | `string` | n/a | yes |
| service\_account\_one | First service Account to add the IAM policies/bindings | `string` | n/a | yes |
| service\_account\_project | Project id of the service account | `string` | n/a | yes |
| service\_account\_two | First service Account to add the IAM policies/bindings | `string` | n/a | yes |
| user\_email | Email for group to receive roles (Ex. user@example.com) | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

