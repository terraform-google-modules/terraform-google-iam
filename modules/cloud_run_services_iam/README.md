# Module Cloud Run Service IAM

This optional module is used to assign cloud run service roles

## Example Usage
```
module "cloud-run-services-iam-bindings" {
  source             = "terraform-google-modules/iam/google//modules/cloud_run_services_iam"
  project            = "my_cloud_run_project"
  cloud_run_services = ["my_cloud_run_service_one", "my_cloud_run_service_two"]
  mode               = "authoritative"

  bindings = {
    "roles/run.invoker" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com",
      "user:my-user@my-org.com",
    ]
    "roles/run.admin" = [
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
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(any)` | n/a | yes |
| cloud\_run\_services | Cloud Run services list to add the IAM policies/bindings | `list(string)` | `[]` | no |
| location | The location of the cloud run instance | `string` | `""` | no |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |
| project | Project to add the IAM policies/bindings | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloud\_run\_services | Cloud Run services which received for bindings. |
| members | Members which were bound to the Cloud Run services. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
