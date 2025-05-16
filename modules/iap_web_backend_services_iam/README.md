# Module iap_web_backend_services_iam

This module is used to manage IAM policies for IAP (Identity-Aware Proxy) Web Backend Services.

## Example Usage

```hcl
module "iap_web_backend_services_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/iap_web_backend_services_iam"
  version = "~> 8.1" // Specify the correct version

  project                = "my-gcp-project-id"
  web_backend_services = ["my-backend-service-one", "my-backend-service-two"]
  mode                   = "additive"

  bindings = {
    "roles/iap.httpsResourceAccessor" = [
      "serviceAccount:my-sa@my-gcp-project-id.iam.gserviceaccount.com",
      "group:my-group@example.com",
      "user:my-user@example.com",
    ]
  }

  conditional_bindings = [
    {
      role        = "roles/iap.httpsResourceAccessor"
      title       = "expires_after_2024_12_31"
      description = "Expiring at midnight of 2024-12-31"
      expression  = "request.time < timestamp(\"2025-01-01T00:00:00Z\")"
      members     = ["user:limited-user@example.com"]
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings. | `map(list(string))` | `{}` | no |
| conditional\_bindings | List of maps of role, condition, and members to add the IAM policies/bindings. | <pre>list(object({<br>    role        = string<br>    title       = string<br>    description = optional(string)<br>    expression  = string<br>    members     = list(string)<br>  }))</pre> | `[]` | no |
| mode | Mode for adding IAM policies/bindings. Valid values are 'additive' or 'authoritative'. | `string` | `"additive"` | no |
| project | Project ID where the IAP Web Backend Services are located. | `string` | `null` | no |
| web\_backend\_services | List of IAP Web Backend Service names to add IAM policies/bindings to. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| members | Members who were bound to the IAP Web Backend Services. |
| roles | Roles which were assigned to members. |
| web\_backend\_services | IAP Web Backend Services which received bindings. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
