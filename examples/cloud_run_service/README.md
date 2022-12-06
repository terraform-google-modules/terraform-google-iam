# Cloud Run Example

This example illustrates how to use the `cloud_run_service_iam` submodule

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloud\_run\_service\_location | The location of the cloud run instance | `string` | n/a | yes |
| cloud\_run\_service\_one | First cloud run service to add the IAM policies/bindings | `string` | n/a | yes |
| cloud\_run\_service\_project | Project id of the cloud run service | `string` | n/a | yes |
| cloud\_run\_service\_two | Second cloud run service to add the IAM policies/bindings | `string` | n/a | yes |
| group\_email | Email for group to receive roles (ex. group@example.com) | `string` | n/a | yes |
| sa\_email | Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com) | `string` | n/a | yes |
| user\_email | Email for group to receive roles (Ex. user@example.com) | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
