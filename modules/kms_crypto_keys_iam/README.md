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
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | map(list(string)) | n/a | yes |
| bindings\_num | Number of bindings, in case using dependencies of other resources' outputs | number | `"0"` | no |
| kms\_crypto\_keys | KMS crypto keys list to add the IAM policies/bindings | list(string) | `<list>` | no |
| kms\_crypto\_keys\_num | Number of KMS crypto keys, in case using dependencies of other resources' outputs | number | `"0"` | no |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | string | `"additive"` | no |

## Outputs

| Name | Description |
|------|-------------|
| kms\_crypto\_keys | KMS crypto keys which received bindings. |
| members | Members which were bound to the KMS crypto keys. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
