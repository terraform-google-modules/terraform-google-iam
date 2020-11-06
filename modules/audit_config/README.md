# Module audit_config

This optional module is used to configure audit log configs for a project.

## Example Usage
```
module "audit_log_config" {
  source           = "terraform-google-modules/iam/google//modules/audit_config"

  project          = my-project
audit_log_config = [
    {
      service          = "pubsub.googleapis.com"
      log_type         = "DATA_READ"
      exempted_members = [
            "group:my-group@my-org.com",
            "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
            "user:my-user@my-org.com"
          ]
    },
    {
      service          = "storage.googleapis.com"
      log_type         = "DATA_WRITE"
      exempted_members = [
            "group:my-group@my-org.com",
            "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
            "user:my-user@my-org.com"
          ]
    },
    {
      service          = "pubsub.googleapis.com"
      log_type         = "DATA_WRITE"
      exempted_members = [
            "group:my-group@my-org.com",
            "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
            "user:my-user@my-org.com"
          ]
    }
  ]

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| audit\_log\_config | List of objects to be added to audit log config | object | n/a | yes |
| project | Project to add the IAM policies/bindings | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| audit\_log\_config | Map of log type and exempted members to be added to service |
