# Module Custom Role IAM

This optional module is used to create custom roles at organization or project level.

## Usage

```hcl
locals {
  role_permissions = ["iam.roles.list", "iam.roles.create", "iam.roles.delete"]
}

module "custom-roles" {
  source = "../../modules/custom_role_iam/"

  role_level  = "project"
  org_id      = "123456789"
  project_id  = "project_id_123"
  role_id     = "custom_role_id"
  title       = "Custom Role Unique Title"
  description = "Custom Role Description"
  permissions = local.role_permissions
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| description | Description of Custom role. | string | n/a | yes |
| org\_id | Organization ID | string | n/a | yes |
| permissions | IAM permissions assigned to Custom Role. | list(string) | n/a | yes |
| project\_id | Project ID | string | n/a | yes |
| role\_id | ID of the Custom Role. | string | n/a | yes |
| role\_level | String variable to denote if custom role being created is at project or organization level. | string | n/a | yes |
| title | Title of the Custom Role. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| custom\_role\_id | Custom Role ID created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
