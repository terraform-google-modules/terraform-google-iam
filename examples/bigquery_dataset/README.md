# BigQuery Topic Example

This example illustrates how to use the `pubsub_topics_iam` submodule

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bigquery\_dataset\_one | First bigquery dataset to add the IAM policies/bindings | `string` | n/a | yes |
| bigquery\_dataset\_project | Project id of the pub/sub topic | `string` | n/a | yes |
| bigquery\_dataset\_two | Second bigquery dataset to add the IAM policies/bindings | `string` | n/a | yes |
| group\_email | Email for group to receive roles (ex. group@example.com) | `string` | n/a | yes |
| sa\_email | Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com) | `string` | n/a | yes |
| user\_email | Email for group to receive roles (Ex. user@example.com) | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
