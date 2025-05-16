# IAP Web Backend Example

This example illustrates how to use the `iap_web_backend_services_iam` submodule 
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| group\_email | Email for group to receive IAP roles (e.g., group@example.com) | `string` | `"iap_viewers_group@example.com"` | no |
| project\_id | The project ID to host the backend service and apply IAM policies | `string` | n/a | yes |
| user\_email | Email for user to receive IAP roles (e.g., user@example.com) | `string` | `"iap_user@example.com"` | no |
| web\_backend\_service\_additive\_names | A list of existing web backend service names to apply additive IAM policies to. | `list(string)` | <pre>[<br>  "iap-example-service"<br>]</pre> | no |
| web\_backend\_service\_authoritative\_names | A list of existing web backend service names to apply authoritative IAM policies to. | `list(string)` | <pre>[<br>  "iap-example-service"<br>]</pre> | no |

## Outputs

No outputs.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
