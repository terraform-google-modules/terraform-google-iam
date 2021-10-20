# Module bigquery_datasets IAM

This submodule is used to assign BigQuery dataset roles.

## Example Usage
```
module "bigquery_dataset-iam-bindings" {
  source             = "terraform-google-modules/iam/google//modules/bigquery_datasets_iam"
  project            = "my-bigquery_dataset_project"
  bigquery_datasets  = ["my_big_query_one", "my_bigquery_dataset_two"]
  mode               = "additive"

  bindings = {
    "roles/bigquery.dataViewer" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com",
      "user:my-user@my-org.com",
    ]
    "roles/bigquery.dataEditor" = [
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
|------|-------------|------|---------|:--------:|
| bigquery\_datasets | BigQuery dataset IDs list to add the IAM policies/bindings | `list(string)` | n/a | yes |
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(any)` | n/a | yes |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |
| project | Project to add the IAM policies/bindings | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bigquery\_datasets | Bigquery dataset IDs which received for bindings. |
| members | Members which were bound to the bigquery datasets. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
