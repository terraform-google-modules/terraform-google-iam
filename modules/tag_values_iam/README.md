# Module DNS Zone IAM

This submodule is used to assign roles on DNS zones.

## Example Usage
```
module "dns_zones_iam_binding" {
  source  = "../../modules/dns_zones_iam/"
  project = var.project_id
  managed_zones = [
    google_dns_managed_zone.dns_zone_one.name,
  ]
  mode = "authoritative"

  bindings = {
    "roles/viewer" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/dns.reader" = [
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
| tag\_values | List of tag values to add the IAM policies/bindings | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| members | Members which were bound to the Tag keys. |
| roles | Roles which were assigned to members. |
| tag\_keys | Tag keys which received for bindings. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
