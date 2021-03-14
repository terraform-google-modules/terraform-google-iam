# Module Member IAM

This optional module is used to assign service account roles

## Example Usage
```
module "member_roles" {
  source                  = "terraform-google-modules/iam/google//modules/member_iam"
  service_account_address = "my-sa@my-project.iam.gserviceaccount.com"
  prefix                  = "serviceAccount"
  project_id              = "my-project-one"
  project_roles           = ["roles/compute.networkAdmin", "roles/appengine.appAdmin"]
}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| prefix | Prefix member or group or serviceaccount | `string` | `"serviceAccount"` | no |
| project\_id | Project id | `string` | n/a | yes |
| project\_roles | List of IAM roles | `list(string)` | n/a | yes |
| service\_account\_address | Service account address | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| project\_id | Project id. |
| roles | Project roles. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
