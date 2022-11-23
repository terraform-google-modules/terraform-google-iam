# Tasks Queue Example

This example illustrates how to use the `tasks_queue_iam` submodule

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| group\_email | Email for group to receive roles (ex. group@example.com) | `string` | n/a | yes |
| sa\_email | Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com) | `string` | n/a | yes |
| tasks\_queue\_location | Region of the Tasks Queue | `string` | n/a | yes |
| tasks\_queue\_one | First Tasks Queue to add the IAM policies/bindings | `string` | n/a | yes |
| tasks\_queue\_project | Project id of the Tasks Queue | `string` | n/a | yes |
| tasks\_queue\_two | Second Tasks Queue to add the IAM policies/bindings | `string` | n/a | yes |
| user\_email | Email for group to receive roles (Ex. user@example.com) | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
