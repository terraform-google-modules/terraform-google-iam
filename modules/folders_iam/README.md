# Module folder IAM

This optional module is used to assign folder roles

## Usage

```hcl
module "folder-iam" {
  source  = "terraform-google-modules/iam/google//modules/folders_iam"
  folders = ["my-folder-name"]

  mode = "additive"

  bindings = {
    "roles/resourcemanager.folderEditor" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com",
    ]

    "roles/resourcemanager.folderViewer" = [
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
| folders | Folders list to add the IAM policies/bindings | list(string) | `<list>` | no |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | string | `"additive"` | no |

## Outputs

| Name | Description |
|------|-------------|
| folders | Folders which received bindings. |
| members | Members which were bound to the folders. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
