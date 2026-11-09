# Cloud Run Job IAM

This module manages IAM authentication for Cloud Run jobs.

## Usage

Basic usage of this module:

```hcl
module "cloud_run_v2_jobs_iam" {
  source = "terraform-google-modules/iam/google//modules/cloud_run_v2_jobs_iam"

  project = "my-project"
  location = "us-central1"
  cloud_run_jobs = ["my-job"]

  bindings = {
    "roles/run.invoker" = [
      "user:user@example.com",
    ]
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(any)` | n/a | yes |
| cloud_run_jobs | Cloud Run jobs list to add the IAM policies/bindings | `list(string)` | `[]` | no |
| location | The location of the cloud run job | `string` | `""` | no |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |
| project | Project to add the IAM policies/bindings | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloud_run_jobs | Cloud Run jobs which received for bindings. |
| members | Members which were bound to the Cloud Run jobs. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
