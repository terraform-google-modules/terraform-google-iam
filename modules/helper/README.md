# IAM helper

This is a helper module. Do not use this module directly.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(list(string))` | `{}` | no |
| conditional\_bindings | List of maps of role and respective conditions, and the members to add the IAM policies/bindings | <pre>list(object({<br>    role        = string<br>    title       = string<br>    description = string<br>    expression  = string<br>    members     = list(string)<br>  }))</pre> | `[]` | no |
| entities | Entities list to add the IAM policies/bindings | `list(string)` | n/a | yes |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |

## Outputs

| Name | Description |
|------|-------------|
| bindings\_additive | Map of additive bindings for entities. Unwinded by members. |
| bindings\_authoritative | Map of authoritative bindings for entities. Unwinded by roles. |
| bindings\_by\_member | List of bindings for entities unwinded by members. |
| set\_additive | A set of additive binding keys (from bindings\_additive) to be used in for\_each. Unwinded by members. |
| set\_authoritative | A set of authoritative binding keys (from bindings\_authoritative) to be used in for\_each. Unwinded by roles. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
