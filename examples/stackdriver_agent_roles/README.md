# Stackdriver Agent Roles

Applies the roles necessary to write metrics and logs to Stackdriver to a given service account.

## Quick Start

[![Open in Cloud Shell](http://www.gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_image=gcr.io/graphite-cloud-shell-images/terraform:latest&cloudshell_git_repo=https://github.com/terraform-google-modules/terraform-google-iam.git&cloudshell_working_dir=examples/stackdriver_agent_roles&cloudshell_print=CLOUDSHELL_INSTRUCTIONS.txt)

1. Use the above link to open a Cloud Shell
2. In the Cloud Shell, run `gcloud config set project <PROJECT_ID>`, where `<PROJECT_ID>` is the GCP project in which you wish to grant roles
3. Run `terraform init && terraform apply` and fill in the relevant service account email when prompted.

[^]: (autogen_docs_start)


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| service_account_email | The service account email to enable Stackdriver agent roles on | string | - | yes |

[^]: (autogen_docs_end)
