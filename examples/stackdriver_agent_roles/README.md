# Stackdriver Agent Roles

Applies the roles necessary to write metrics and logs to Stackdriver to a given service account.

## Quick Start

[![Open in Cloud Shell](http://www.gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_image=gcr.io/graphite-cloud-shell-images/terraform:latest&cloudshell_git_repo=https://github.com/terraform-google-modules/terraform-google-iam.git&cloudshell_working_dir=examples/stackdriver_agent_roles&cloudshell_tutorial=CLOUDSHELL_TUTORIAL.md)

1. Use the above link to open a Cloud Shell
2. Follow the tutorial presented in Cloud Shell (see also [CLOUDSHELL_TUTORIAL.md](./CLOUDSHELL_TUTORIAL.md)).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project | GCP project in which you wish to grant roles to the service account | `string` | n/a | yes |
| service\_account\_email | The service account email to enable Stackdriver agent roles on | `string` | n/a | yes |

## Outputs

No outputs.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
