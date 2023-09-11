# Google IAM Terraform Module

This is a collection of submodules that make it easier to non-destructively manage multiple IAM roles for resources on Google Cloud Platform:
* [Artifact Registry IAM](modules/artifact_registry_iam)
* [Audit Config](modules/audit_config)
* [BigQuery IAM](modules/bigquery_datasets_iam)
* [Billing Accounts IAM](modules/billing_accounts_iam)
* [Cloud Run Service IAM](modules/cloud_run_services_iam)
* [Custom Role IAM](modules/custom_role_iam)
* [DNS Zone IAM](modules/dns_zones_iam)
* [Folders IAM](modules/folders_iam)
* [KMS Crypto Keys IAM](modules/kms_crypto_keys_iam)
* [KMS_Key Rings IAM](modules/kms_key_rings_iam)
* [Organizations IAM](modules/organizations_iam)
* [Projects IAM](modules/projects_iam)
* [Pubsub Subscriptions IAM](modules/pubsub_subscriptions_iam)
* [Pubsub Topics IAM](modules/pubsub_topics_iam)
* [Secret Manager IAM](modules/secret_manager_iam)
* [Service Accounts IAM](modules/service_accounts_iam)
* [Storage Buckets IAM](modules/storage_buckets_iam)
* [Subnets IAM](modules/subnets_iam)
* [Tag Keys IAM](modules/tag_keys_iam)
* [Tag Values IAM](modules/tag_values_iam)

## Compatibility
This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+. If you find incompatibilities using Terraform >=0.13, please open an issue.
 If you haven't
[upgraded](https://www.terraform.io/upgrade-guides/0-13.html) and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [v6.4.1](https://registry.terraform.io/modules/terraform-google-modules/-iam/google/v6.4.1).

## Upgrading

The following guides are available to assist with upgrades:

- [4.0 -> 5.0](./docs/upgrading_to_iam_5.0.md)
- [3.0 -> 4.0](./docs/upgrading_to_iam_4.0.md)
- [2.0 -> 3.0](./docs/upgrading_to_iam_3.0.md)

## Usage

Full examples are in the [examples](./examples/) folder, but basic usage is as follows for managing roles on two projects:

```hcl
module "projects_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 7.7"

  projects = ["project-123456", "project-9876543"]

  bindings = {
    "roles/storage.admin" = [
      "group:test_sa_group@lnescidev.com",
      "user:someone@google.com",
    ]

    "roles/compute.networkAdmin" = [
      "group:test_sa_group@lnescidev.com",
      "user:someone@google.com",
    ]

    "roles/compute.imageUser" = [
      "user:someone@google.com",
    ]
  }
}
```

The module also offers an **authoritative** mode which will remove all roles not assigned through Terraform. This is an example of using the authoritative mode to manage access to a storage bucket:

```hcl
module "storage_buckets_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/storage_buckets_iam"
  version = "~> 8.0"

  storage_buckets = ["my-storage-bucket"]

  mode = "authoritative"

  bindings = {
    "roles/storage.legacyBucketReader" = [
      "user:josemanuelt@google.com",
      "group:test_sa_group@lnescidev.com",
    ]

    "roles/storage.legacyBucketWriter" = [
      "user:josemanuelt@google.com",
      "group:test_sa_group@lnescidev.com",
    ]
  }
}
```

### Additive and Authoritative Modes

The `mode` variable controls a submodule's behavior, by default it's set to "additive", possible options are:

  - additive: add members to role, old members are not deleted from this role.
  - authoritative: set the role's members (including removing any not listed), unlisted roles are not affected.

In authoritative mode, a submodule takes full control over the IAM bindings listed in the module. This means that any members added to roles outside the module will be removed the next time Terraform runs. However, roles not listed in the module will be unaffected.

In additive mode, a submodule leaves existing bindings unaffected. Instead, any members listed in the module will be added to the existing set of IAM bindings. However, members listed in the module *are* fully controlled by the module. This means that if you add a binding via the module and later remove it, the module will correctly handle removing the role binding.

## Caveats

### Referencing values/attributes from other resources

Each submodule performs operations over some variables before making any changes on the IAM bindings in GCP. Because of the limitations of `for_each` ([more info](https://www.terraform.io/docs/configuration/resources.html#using-expressions-in-for_each)), which is widely used in the submodules, there are certain limitations to what kind of dynamic values you can provide to a submodule:

1. Dynamic entities (for example `projects`) are only allowed for 1 entity.
2. If you pass 2 or more entities (for example `projects`), the configuration **MUST** be static, meaning that it can't use any of the other resources' fields to get the entity name from (this includes getting the randomly generated hashes through the `random_id` resource).
3. The role names themselves can never be dynamic.
4. Members may only be dynamic in `authoritative` mode.

## IAM Bindings

You can choose the following resource types to apply the IAM bindings:

- Projects (`projects` variable)
- Organizations(`organizations` variable)
- Folders (`folders` variable)
- Service Accounts (`service_accounts` variable)
- Subnetworks (`subnets` variable)
- Storage buckets (`storage_buckets` variable)
- Pubsub topics (`pubsub_topics` variable)
- Pubsub subscriptions (`pubsub_subscriptions` variable)
- Kms Key Rings (`kms_key_rings` variable)
- Kms Crypto Keys (`kms_crypto_keys` variable)
- Secret Manager Secrets (`secrets` variable)
- DNS Zones (`managed_zones` variable)

Set the specified variable on the module call to choose the resources to affect. Remember to set the `mode` [variable](#additive-and-authoritative-modes) and give enough [permissions](#permissions) to manage the selected resource as well. Note that the `bindings` variable accepts an empty map `{}` passed in as an argument in the case that resources don't have IAM bindings to apply.

## Requirements

### Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) >= 0.13.0
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) 2.5
- [terraform-provider-google-beta](https://github.com/terraform-providers/terraform-provider-google-beta) 2.5

### Permissions

In order to execute a submodule you must have a Service Account with an appropriate role to manage IAM for the applicable resource. The appropriate role differs depending on which resource you are targeting, as follows:

- Organization:
  - Organization Administrator: Access to administer all resources belonging to the organization
    and does not include privileges for billing or organization role administration.
  - Custom: Add resourcemanager.organizations.getIamPolicy and
    resourcemanager.organizations.setIamPolicy permissions.
- Project:
  - Owner: Full access and all permissions for all resources of the project.
  - Projects IAM Admin: allows users to administer IAM policies on projects.
  - Custom: Add resourcemanager.projects.getIamPolicy and resourcemanager.projects.setIamPolicy permissions.
- Folder:
  - The Folder Admin: All available folder permissions.
  - Folder IAM Admin: Allows users to administer IAM policies on folders.
  - Custom: Add resourcemanager.folders.getIamPolicy and
    resourcemanager.folders.setIamPolicy permissions (must be added in the organization).
- Service Account:
  - Service Account Admin: Create and manage service accounts.
  - Custom: Add resourcemanager.organizations.getIamPolicy and
    resourcemanager.organizations.setIamPolicy permissions.
- Subnetwork:
  - Project compute admin: Full control of Compute Engine resources.
  - Project compute network admin: Full control of Compute Engine networking resources.
  - Project custom: Add compute.subnetworks.getIamPolicy	and
    compute.subnetworks.setIamPolicy permissions.
- Storage bucket:
  - Storage Admin: Full control of GCS resources.
  - Storage Legacy Bucket Owner: Read and write access to existing
    buckets with object listing/creation/deletion.
  - Custom: Add storage.buckets.getIamPolicy	and
  storage.buckets.setIamPolicy permissions.
- Pubsub topic:
  - Pub/Sub Admin: Create and manage service accounts.
  - Custom: Add pubsub.topics.getIamPolicy and pubsub.topics.setIamPolicy permissions.
- Pubsub subscription:
  - Pub/Sub Admin role: Create and manage service accounts.
  - Custom role: Add pubsub.subscriptions.getIamPolicy and
    pubsub.subscriptions.setIamPolicy permissions.
- Kms Key Ring:
  - Owner: Full access to all resources.
  - Cloud KMS Admin: Enables management of crypto resources.
  - Custom: Add cloudkms.keyRings.getIamPolicy and cloudkms.keyRings.getIamPolicy permissions.
- Kms Crypto Key:
  - Owner: Full access to all resources.
  - Cloud KMS Admin: Enables management of cryptoresources.
  - Custom: Add cloudkms.cryptoKeys.getIamPolicy	and cloudkms.cryptoKeys.setIamPolicy permissions.
- Secret Manager:
    - Secret Manager Admin: Full access to administer Secret Manager.
    - Custom: Add secretmanager.secrets.getIamPolicy and secretmanager.secrets.setIamPolicy permissions.
- DNS Zone:
    - DNS Administrator : Full access to administer DNS Zone.
    - Custom: Add dns.managedZones.setIamPolicy, dns.managedZones.list and dns.managedZones.getIamPolicy permissions.

## Install

### Terraform

Be sure you have the correct Terraform version (0.12), you can choose the binary here:
- https://releases.hashicorp.com/terraform/

### Terraform plugins

Be sure you have the compiled plugins on $HOME/.terraform.d/plugins/

- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) 1.20.0
- [terraform-provider-google-beta](https://github.com/terraform-providers/terraform-provider-google-beta) 1.20.0

See each plugin page for more information about how to compile and use them.

## Fast install (optional)

For a fast install, please configure the variables on init_centos.sh  or init_debian.sh script and then launch it.

The script will do:
- Environment variables setting
- Installation of base packages like wget, curl, unzip, gcloud, etc.
- Installation of go 1.9.0
- Installation of Terraform 0.10.x
- Download the terraform-provider-google plugin
- Compile the terraform-provider-google plugin
- Move the terraform-provider-google to the right location

[v1.1.1]: https://registry.terraform.io/modules/terraform-google-modules/iam/google/1.1.1
[terraform-0.12-upgrade]: https://www.terraform.io/upgrade-guides/0-12.html
