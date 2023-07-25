# PubSub Subscription Example

This example illustrates how to use the `pubsub_subscriptions_iam` submodule

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| group\_email | Email for group to receive roles (ex. group@example.com) | `string` | n/a | yes |
| pubsub\_subscription\_one | First pubsub subscription name to add the IAM policies/bindings | `string` | n/a | yes |
| pubsub\_subscription\_project | Project id of the pub/sub subscription | `string` | n/a | yes |
| pubsub\_subscription\_two | Second pubsub subscription name to add the IAM policies/bindings | `string` | n/a | yes |
| sa\_email | Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com) | `string` | n/a | yes |
| user\_email | Email for group to receive roles (Ex. user@example.com) | `string` | n/a | yes |

## Outputs

No outputs.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
