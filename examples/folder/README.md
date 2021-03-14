# Folder Example

This example illustrates how to use the `folders_iam` submodule

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| folder\_one | The first folder ID to apply IAM bindings | `string` | n/a | yes |
| folder\_two | The second folder ID to apply IAM bindings | `string` | n/a | yes |
| group\_email | Email for group to receive roles (ex. group@example.com) | `string` | n/a | yes |
| sa\_email | Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com) | `string` | n/a | yes |
| user\_email | Email for group to receive roles (Ex. user@example.com) | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

