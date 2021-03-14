# Module Project IAM

This optional module is used to assign project roles

## Example Usage
```
module "project-iam-bindings" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  projects = ["my-project_one", "my-project_two"]
  mode     = "additive"

  bindings = {
    "roles/compute.networkAdmin" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com",
      "user:my-user@my-org.com",
    ]
    "roles/appengine.appAdmin" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com",
      "user:my-user@my-org.com",
    ]
  }

  conditional_bindings = [
    {
      role = "roles/editor"
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
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |
| projects | Projects list to add the IAM policies/bindings | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| members | Members which were bound to projects. |
| projects | Projects wich received bindings. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
