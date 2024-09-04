# Module Privileged Access Manager

This submodule is used to create privileged access manager entitlements

## Example Usage
```
module "dns_zones_iam_binding" {
  source   = "terraform-google-modules/iam/google//modules/dns_zones_iam"
  version  = "~> 8.0"

  entitlement_id = "example-entitlement"
  parent_id      = "parent-project-id"
  parent_type    = "project"
  entitlement_requesters = [
    "group:test-grp-01-poc@imran.joonix.net"
  ]
  entitlement_approvers = [
    "user:abc@example.com"
  ]
  role_bindings = [
    {
      role                 = "roles/storage.admin"
      condition_expression = "request.time < timestamp(\"2024-04-23T18:30:00.000Z\")"
    },
    {
      role = "roles/bigquery.admin"
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| entitlement\_approval\_notification\_recipients | List of email addresses to be notified when a request is granted | `list(string)` | `null` | no |
| entitlement\_approvers | Required List of users, groups or service accounts who can approve this entitlement. Can be one or more of Google Account email, Google Group or Service account | `list(string)` | n/a | yes |
| entitlement\_availability\_notification\_recipients | List of email addresses to be notified when a entitlement is created. These email addresses will receive an email about availability of the entitlement | `list(string)` | `null` | no |
| entitlement\_id | The ID to use for this Entitlement. This will become the last part of the resource name. This value should be 4-63 characters. This value should be unique among all other Entitlements under the specified parent | `string` | n/a | yes |
| entitlement\_requesters | Required List of users, groups, service accounts or domains who can request grants using this entitlement. Can be one or more of Google Account email, Google Group, Service account, or Google Workspace domain | `list(string)` | n/a | yes |
| location | The region of the Entitlement resource | `string` | `"global"` | no |
| max\_request\_duration\_hours | The maximum amount of time for which access would be granted for a request. A requester can choose to ask for access for less than this duration but never more | `number` | `1` | no |
| parent\_id | The ID of organization, folder, or project to create the entitlement in | `string` | n/a | yes |
| parent\_type | Parent type. Can be organization, folder, or project to create the entitlement in | `string` | n/a | yes |
| requester\_justification | If the requester is required to provide a justification | `bool` | `true` | no |
| require\_approver\_justification | Do the approvers need to provide a justification for their actions | `bool` | `true` | no |
| role\_bindings | The maximum amount of time for which access would be granted for a request. A requester can choose to ask for access for less than this duration but never more | <pre>list(object({<br>    role                 = string<br>    condition_expression = optional(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| entitlement | Entitlement created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
