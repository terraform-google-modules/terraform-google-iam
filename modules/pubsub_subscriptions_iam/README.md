# Module pubsub_subscription IAM

This optional module is used to assign pubsub_subscription roles

## Example Usage
```
module "pubsub_subscription-iam-bindings" {
  source               = "terraform-google-modules/iam/google//modules/pubsub_subscriptions_iam"
  project              = "my-pubsub_subscription_project"
  pubsub_subscriptions = ["my-pubsub_subscription_one", "my-pubsub_subscription_two"]
  mode                 = "additive"

  bindings = {
    "roles/pubsub.viewer" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com",
      "user:my-user@my-org.com",
    ]
    "roles/pubsub.editor" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com",
      "user:my-user@my-org.com",
    ]
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(list(string))` | n/a | yes |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |
| project | Project to add the IAM policies/bindings | `string` | `""` | no |
| pubsub\_subscriptions | PubSub Subscriptions list to add the IAM policies/bindings | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| members | Members which were bound to the PubSub Subscription. |
| pubsub\_subscriptions | PubSub Subscriptions which received bindings. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
