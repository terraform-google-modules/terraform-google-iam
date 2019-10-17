# Module storage_bucket IAM

This optional module is used to assign storage_bucket roles

## Example Usage
```
module "storage_bucket-iam-bindings" {
  source          = "terraform-google-modules/iam/google//modules/storage_buckets_iam"
  storage_buckets = ["my-storage_bucket_one", "my-storage_bucket_two"]
  mode            = "additive"

  bindings = {
    "roles/storage.legacyBucketReader" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com",
      "user:my-user@my-org.com",
    ]
    "roles/storage.legacyBucketWriter" = [
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
| storage\_buckets | Storage Buckets list to add the IAM policies/bindings | list(string) | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| members | Members which were bound to the Storage Bucket. |
| roles | Roles which were assigned to members. |
| storage\_buckets | Storage Buckets which received bindings. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
