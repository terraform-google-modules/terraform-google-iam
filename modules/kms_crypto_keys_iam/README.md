# Module kms_crypto_key IAM

This optional module is used to assign kms_crypto_key roles

## Example Usage
```
module "kms_crypto_key-iam-bindings" {
  source          = "terraform-google-modules/iam/google//modules/kms_crypto_keys_iam"
  kms_crypto_keys = ["my-kms_crypto_key_one", "my-kms_crypto_key_two"]

  mode = "authoritative"

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
| kms\_crypto\_keys | KMS crypto keys list to add the IAM policies/bindings | `list(string)` | `[]` | no |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |

## Outputs

| Name | Description |
|------|-------------|
| kms\_crypto\_keys | KMS crypto keys which received bindings. |
| members | Members which were bound to the KMS crypto keys. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
