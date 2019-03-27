# Stackdriver Agent Roles for Service Account

### Configuration

### Set your Project ID

In the Shell below, run `gcloud config set project <PROJECT_ID>`, where `<PROJECT_ID>` is the GCP project in which you wish to grant roles to the service account.

### Initialize Terraform

In the Shell, run `terraform init` to initialize `terraform` and download necessary support files.

### Run Terraform

In the Shell, run `terraform apply`. When prompted, enter the email address for the service account that you'd like to grant these roles to. Review the changes that `terraform` would like to apply, then type `yes` to confirm.

### You're Done!

If `terraform` completes without error, the IAM roles `roles/logging.logWriter` and `roles/monitoring.metricWriter` have been applied to the service account you specified.
