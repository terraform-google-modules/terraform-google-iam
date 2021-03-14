# Subnet Example

This example illustrates how to use the `subnets_iam` submodule

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| group\_email | Email for group to receive roles (ex. group@example.com) | `string` | n/a | yes |
| project | The project where the subnet resides | `string` | n/a | yes |
| region | The region where the subnet resides | `string` | n/a | yes |
| sa\_email | Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com) | `string` | n/a | yes |
| subnet\_one | First subnet id to add the IAM policies/bindings | `string` | n/a | yes |
| subnet\_two | Second subnet id to add the IAM policies/bindings | `string` | n/a | yes |
| user\_email | Email for group to receive roles (Ex. user@example.com) | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Caveats
The module expects the subnets to be provided fully qualified.  (ex: `projects/<project_id>/regions/<region>/subnetworks/<subnet_name>`)  This example takes your inputted project, region and subnets to form the fully qualified subnet ids.
