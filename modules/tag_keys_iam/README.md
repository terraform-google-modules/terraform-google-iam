# Module Tag Keys IAM

This submodule is used to assign roles on Tag Keys.

## Example Usage
```
module "tag_keys_iam_binding" {
  source  = "terraform-google-modules/iam/google//modules/tag_keys_iam"
  version = "~> 8.0"
  tag_keys = [
    google_tags_tag_key.tag_key.name,
  ]
  mode = "authoritative"

  bindings = {
    "roles/viewer" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(any)` | n/a | yes |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |
| tag\_keys | List of tag keys to add the IAM policies/bindings | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| members | Members which were bound to the Tag keys. |
| roles | Roles which were assigned to members. |
| tag\_keys | Tag keys which received for bindings. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
