# Storage Bucket Example

This example illustrates how to use the `storage_buckets_iam` submodule

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| group\_email | Email for group to receive roles (ex. group@example.com) | `string` | n/a | yes |
| sa\_email | Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com) | `string` | n/a | yes |
| storage\_bucket\_one | First name of a GCS bucket to add the IAM policies/bindings | `string` | n/a | yes |
| storage\_bucket\_two | Second name of a GCS bucket to add the IAM policies/bindings | `string` | n/a | yes |
| user\_email | Email for group to receive roles (Ex. user@example.com) | `string` | n/a | yes |

## Outputs

No outputs.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
