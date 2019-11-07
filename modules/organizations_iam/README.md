# Module organization IAM

This optional module is used to assign organization roles

## Example Usage
```
module "organization-iam-bindings" {
  source        = "terraform-google-modules/iam/google//modules/organizations_iam"
  organizations = ["my-organization_one", "my-organization_two"]
  mode          = "authoritative"

  bindings = {
    "roles/resourcemanager.organizationViewer" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com",
      "user:my-user@my-org.com",
    ]
    "roles/resourcemanager.projectDeleter" = [
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
|------|-------------|:----:|:-----:|:-----:|
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | map(list(string)) | n/a | yes |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | string | `"additive"` | no |
| organizations | Organizations list to add the IAM policies/bindings | list(string) | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| members | Members which were bound to organizations. |
| organizations | Organizations which received bindings. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
