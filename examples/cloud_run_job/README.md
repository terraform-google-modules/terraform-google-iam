# Cloud Run Job Example

This example illustrates how to use the `cloud_run_v2_jobs_iam` submodule

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloud\_run\_job\_one | First cloud run job to add the IAM policies/bindings | `string` | n/a | yes |
| cloud\_run\_job\_two | Second cloud run job to add the IAM policies/bindings | `string` | n/a | yes |
| group\_email | Email for group to receive roles (ex. group@example.com) | `string` | n/a | yes |
| location | The location of the cloud run job | `string` | n/a | yes |
| project | Project id of the cloud run job | `string` | n/a | yes |
| sa\_email | Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com) | `string` | n/a | yes |
| user\_email | Email for group to receive roles (Ex. user@example.com) | `string` | n/a | yes |

## Outputs

No outputs.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
