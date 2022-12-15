# Service Account Example

This example illustrates how to use the `service_accounts_iam` submodule

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| group\_email | Email for group to receive roles (ex. group@example.com) | `string` | `"goose_net_admins@goosecorp.org"` | no |
| sa\_email | Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com) | `string` | `"sa-tf-test-receiver-01@ci-iam-0c5f.iam.gserviceaccount.com"` | no |
| service\_account\_one | First service Account to add the IAM policies/bindings | `string` | `"sa-tf-test-01@ci-iam-0c5f.iam.gserviceaccount.com"` | no |
| service\_account\_project | Project id of the service account | `string` | `"ci-iam-0c5f"` | no |
| service\_account\_two | First service Account to add the IAM policies/bindings | `string` | `"sa-tf-test-02@ci-iam-0c5f.iam.gserviceaccount.com"` | no |
| user\_email | Email for group to receive roles (Ex. user@example.com) | `string` | `"awmalik@google.com"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

