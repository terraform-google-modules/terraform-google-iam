# DNS ZOne Example

This example illustrates how to use the `privileged_access_manager` submodule

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| group\_email | Email for group to receive roles (ex. group@example.com) | `string` | n/a | yes |
| project\_id | Project ID to create BigQuery resources in | `string` | n/a | yes |
| sa\_email | Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com) | `string` | n/a | yes |
| user\_email | Email for user to receive roles (Ex. user@example.com) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_id | SSM Instance ID |
| repository\_id | SSM repository ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
