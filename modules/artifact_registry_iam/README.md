# Module Artifact registry repository IAM

This optional module is used to assign artifact registry repository iam roles.

## Example Usage
```
module "artifact-registry-repository-iam-bindings" {
  source   = "terraform-google-modules/iam/google//modules/artifact_registry_iam"
  project      = "my-project"
  repositories = ["my-project_one", "my-project_two"]
  location     = "us-central-1"
  mode         = "additive"

  bindings = {
    "roles/compute.networkAdmin" = [
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
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(list(string))` | `{}` | no |
| location | Location of the provided artifact registry repositories | `string` | n/a | yes |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |
| project | Project where the artifact registry repositories are placed | `string` | n/a | yes |
| repositories | Artifact registry repositories list to add the IAM policies/bindings | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| members | Members which were bound to artifact registry repositories. |
| repositories | Artifact registry repositories which received bindings. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
