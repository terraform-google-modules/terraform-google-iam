# Module subnet IAM

This optional module is used to assign subnet roles

## Example Usage
```
module "subnet-iam-bindings" {
  source = "terraform-google-modules/iam/google//modules/subnets_iam"

  subnets        = ["my-subnet_one", "my-subnet_two"]
  subnets_region = "my-region"
  project        = "my-project"
  mode           = "authoritative"
  bindings = {
    "roles/compute.networkUser" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com",
      "user:my-user@my-org.com",
    ]
    "roles/compute.networkViewer" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com",
      "user:my-user@my-org.com",
    ]
  }
  conditional_bindings = [
    {
      role = "roles/compute.networkAdmin"
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
| project | Project to add the IAM policies/bindings | `string` | `""` | no |
| subnets | Subnetwork list to add the IAM policies/bindings | `list(string)` | `[]` | no |
| subnets\_region | Subnetworks region | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| members | Members which were bound to the Subnetwork. |
| roles | Roles which were assigned to members. |
| subnets | Subnetworks which received bindings. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
