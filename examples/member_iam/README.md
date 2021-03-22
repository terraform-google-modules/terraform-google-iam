# Member iam Module Example

This example illustrates how to use the `member_iam` submodule

## Requirements
### Installed Software
- [Terraform](https://www.terraform.io/downloads.html) ~> 0.12.6
- [Terraform Provider for GCP](https://github.com/terraform-providers/terraform-provider-google) ~> 2.19
- [Terraform Provider for GCP Beta](https://github.com/terraform-providers/terraform-provider-google-beta) ~> 2.19

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | Project id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| project\_id | Project id. |
| roles | Project roles. |
| service\_account\_address | Member which was bound to projects. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
