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
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | map(list(string)) | n/a | yes |
| bindings\_num | Number of bindings, in case using dependencies of other resources' outputs | number | `"0"` | no |
| kms\_key\_rings | KMS Key Rings list to add the IAM policies/bindings | list(string) | `<list>` | no |
| kms\_key\_rings\_num | Number of KMS Key Rings, in case using dependencies of other resources' outputs | number | `"0"` | no |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | string | `"additive"` | no |

## Outputs

| Name | Description |
|------|-------------|
| kms\_key\_rings | KMS key rings which received bindings. |
| members | Members which were bound to the KMS key rings. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
