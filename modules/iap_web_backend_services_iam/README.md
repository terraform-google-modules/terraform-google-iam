# Module iap_web_backend_services IAM

This optional module is used to assign iap_web_backend_services roles

## Example Usage
```
module "iap_web_backend_services_iam" {
  source   = "terraform-google-modules/iam/google//modules/iap_web_backend_services_iam"
  version  = "~> 8.0"

  iap_web_backend_services = ["my-iap-backend-service-name"]
  mode            = "additive"

  bindings = {
    "roles/iap.httpsResourceAccessor" = [
      "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
      "group:my-group@my-org.com",
      "user:my-user@my-org.com",
    ]
  }
  conditional_bindings = [
    {
      role = "roles/iap.httpsResourceAccessor"
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
| iap\_web\_backend\_services | IAP Web Backend Service list to add the IAM policies/bindings | `list(string)` | `[]` | no |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | `string` | `"additive"` | no |
| project | Project where the iap\_web\_backend\_services bindings are placed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| iap\_web\_backend\_services | IAP Web Backend Services which received bindings. |
| members | Members which were bound to the IAP Web Backend Service. |
| roles | Roles which were assigned to members. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
