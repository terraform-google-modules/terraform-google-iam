# Module Tasks Queue IAM

This optional module is used to assign Tasks queue roles

## Usage

```hcl
module "tasks_queue_iam" {
  source       = "terraform-google-modules/iam/google//modules/tasks_queue_iam"
  project      = "gcp-project-id"
  tasks_queues = ["tasks-queue-one", "tasks-queue-two"]
  location     = "us-central1"
  mode         = "additive"

  bindings = {
    "roles/cloudtasks.enqueuer" = [
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
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(list(string))` | `{}` | no |
| location | Location of the provided tasks queues | `string` | n/a | yes |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |
| project | Project to add the IAM policies/bindings | `string` | `""` | no |
| tasks\_queues | Tasks Queues list to add the IAM policies/bindings | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| members | Members which were bound to the Tasks Queues. |
| roles | Roles which were assigned to members. |
| tasks\_queues | Tasks Queues which received bindings. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
