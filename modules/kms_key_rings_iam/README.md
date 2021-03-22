# Module kms_key_ring IAM

This optional module is used to assign kms_key_ring roles


## Example Usage
```
module "kms_key_ring-iam-bindings" {
  source        = "terraform-google-modules/iam/google//modules/kms_key_rings_iam"
  kms_key_rings = ["my-kms_key_ring_one", "my-kms_key_ring_two"]
  mode          = "additive"

  bindings = {
    "roles/cloudkms.cryptoKeyEncrypter" = [
      "user:my-user@my-org.com",
      "group:my-group@my-org.com",
    ]
    "roles/cloudkms.cryptoKeyDecrypter" = [
      "user:my-user@my-org.com",
      "group:my-group@my-org.com",
    ]
  }
  conditional_bindings = [
    {
      role = "roles/cloudkms.admin"
      title = "expires_after_2019_12_31"
      description = "Expiring at midnight of 2019-12-31"
      expression = "request.time < timestamp(\"2020-01-01T00:00:00Z\")"
      members = ["user:my-user@my-org.com"]
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(list(string))` | `{}` | no |
| conditional\_bindings | List of maps of role and respective conditions, and the members to add the IAM policies/bindings | <pre>list(object({<br>    role        = string<br>    title       = string<br>    description = string<br>    expression  = string<br>    members     = list(string)<br>  }))</pre> | `[]` | no |
| kms\_key\_rings | KMS Key Rings list to add the IAM policies/bindings | `list(string)` | `[]` | no |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |

## Outputs

| Name | Description |
|------|-------------|
| kms\_key\_rings | KMS key rings which received bindings. |
| members | Members which were bound to the KMS key rings. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
