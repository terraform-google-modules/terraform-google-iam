# Module Custom Role IAM

This optional module is used to create custom roles at organization or project level.

## Usage - Custom Role at Organization Level

```hcl
module "custom-roles" {
  source = "terraform-google-modules/iam/google//modules/custom_role_iam"

  target_level = "org"
  org_id       = "123456789"
  role_id      = "custom_role_id"
  title        = "Custom Role Unique Title"
  description  = "Custom Role Description"
  permissions  = ["iam.roles.list", "iam.roles.create", "iam.roles.delete"]
}
```

## Usage - Custom Role at Project Level

```hcl
module "custom-roles" {
  source = "terraform-google-modules/iam/google//modules/custom_role_iam"

  target_level = "project"
  project_id   = "project_id_123"
  role_id      = "custom_role_id"
  title        = "Custom Role Unique Title"
  description  = "Custom Role Description"
  permissions  = ["iam.roles.list", "iam.roles.create", "iam.roles.delete"]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| description | Description of Custom role. | string | `"This is a Custom Role."` | no |
| permissions | IAM permissions assigned to Custom Role. | list(string) | n/a | yes |
| role\_id | ID of the Custom Role. | string | n/a | yes |
| stage | The current launch stage of the role. Defaults to GA. | string | `"GA"` | no |
| target\_id | Variable for project or organization ID. | string | n/a | yes |
| target\_level | String variable to denote if custom role being created is at project or organization level. | string | `"project"` | no |
| title | Human-readable title of the Custom Role, defaults to role_id. | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| custom\_role\_id | ID of the custom role created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
