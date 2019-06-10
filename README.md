# Google IAM Terraform Module

This Terraform module makes it easier to non-destructively manage multiple IAM roles for resources on Google Cloud Platform.

## Usage

Full examples are in the [examples](./examples/) folder, but basic usage is as follows for managing roles on two projects:

```hcl
module "iam_binding" {
  source = "terraform-google-modules/iam/google"

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
module "storage_buckets_iam_binding" {
  source          = "terraform-google-modules/iam/google"
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

### Variables

Following variables are the most important to control module's behavior:

- Mode

    This variable controls the module's behavior, by default is set to "additive", possible options are:

      - additive: add members to role, old members are not deleted from this role.
      - authoritative: set the role's members, other roles' members are not deleted.

- Bindings

  Is a map of role (key) and list of members (value) with member type prefix, for example:

```hcl
        bindings = {
            "roles/<some_role>" = [
                "user:someone@somewhere.com",
                "group:somepeople@somewhereelse.com"
            ]
        }
```

- Project

  This variable can be defined either on `provider` section and the module calling itself. It is only used for the following resources:

  - `service_accounts`
  - `pubsub_topics`
  - `pubsub_subscriptions`

[^]: (autogen_docs_start)

#### Additive and Authoritative Modes

This module includes two modes: additive and authoritative.

In authoritative mode, the module takes full control over the IAM bindings listed in the module. This means that any members added to roles outside the module will be removed the next time Terraform runs. However, roles not listed in the module will be unaffected.

In additive mode, this module leaves existing bindings unaffected. Instead, any members listed in the module will be added to the existing set of IAM bindings. However, members listed in the module *are* fully controlled by the module. This means that if you add a binding via the module and later remove it, the module will correctly handle removing the role binding.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | map | - | yes |
| folders | Folders list to add the IAM policies/bindings | list | `<list>` | no |
| kms_crypto_keys | Kms Crypto Key list to add the IAM policies/bindings | list | `<list>` | no |
| kms_key_rings | Kms Key Rings list to add the IAM policies/bindings | list | `<list>` | no |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | string | `additive` | no |
| organizations | Organizations list to add the IAM policies/bindings | list | `<list>` | no |
| project | Project to add the IAM policies/bindings | string | `` | no |
| projects | Projects list to add the IAM policies/bindings | list | `<list>` | no |
| pubsub_subscriptions | Pubsub subscriptions list to add the IAM policies/bindings | list | `<list>` | no |
| pubsub_topics | Pubsub topics list to add the IAM policies/bindings | list | `<list>` | no |
| service_accounts | Service Accounts list to add the IAM policies/bindings | list | `<list>` | no |
| storage_buckets | Buckets list to add the IAM policies/bindings | list | `<list>` | no |
| subnets | Subnets list to add the IAM policies/bindings | list | `<list>` | no |

[^]: (autogen_docs_end)

## Caveats

### Referencing values/attributes from other resources

This Terraform module performs operations over some variables before making any changes on the IAM bindings in GCP.

Because of that, it is important to note that putting a value or attribute of a resource within the following variables, will cause an error:

- `bindings`
- `projects`
- `organizations`
- `folders`
- `service_accounts`
- `subnets`
- `storage_buckets`
- `pubsub_topics`
- `pubsub_subscriptions`
- `kms_key_rings`
- `kms_crypto_keys`

For example, this will fail:

```hcl
resource google_folder "my_new_folder" {
  display_name = "folder-test"
  parent = "76543265432"
}

resource "google_service_account" "my_service_account" {
  account_id   = "my-new-service-account"
}

module "iam_binding" {
  source = "terraform-google-modules/iam/google"
  mode   = "authoritative"

  folders = ["${google_folder.my_new_folder.id}"]

  bindings = {
    "roles/storage.admin" = [
      "group:test_sa_group@lnescidev.com",
      "serviceAccount:${google_service_account.my_service_account.id}",
    ]

    "roles/compute.networkAdmin" = [
      "group:test_sa_group@lnescidev.com",
      "user:someone@google.com",
    ]
  }
}
```

First, because the `folders` variable has a reference to a resource that is not already created (`my_new_folder`). Second because the `bindings` variable has a reference to `my_service_account` and it is not created yet. The error output is as follows: `(...) value of 'count' cannot be computed`

#### Workaround

To avoid this error, use values or attributes of resources that are already created before calling this module.

Note that as soon as the resources have been created once they **can** be referenced successfully (once they are in the Terraform state file).

Therefore, a simple workaround is as follows:

1. Comment out the call to this module.
2. Run `terraform apply` to create the other resources and persist them to the state file.
3. Uncomment this module.
4. Run `terraform apply` to apply the bindings.

## IAM Bindings

You can choose the following resource types for apply the IAM bindings:

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

Set the specified variable on the module call to choose the resources to affect. Remember to set the `mode` [variable](#variables) and give enough [permissions](#permissions) to manage the selected resource as well.

## File structure

The project has the following folders and files:

- /: root folder.
- /examples: examples for using this module.
- /scripts: Scripts for specific tasks on module (see Infrastructure section on this file).
- /test: Folders with files for testing the module (see Testing section on this file).
- /main.tf: main file for this module, contains all the logic for operate the module.
- /*_iam.tf: files for manage the IAM bindings for each resource type.
- /variables.tf: all the variables for the module.
- /output.tf: the outputs of the module.
- /readme.MD: this file.

## Requirements

### Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) 0.12
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) 2.5
- [terraform-provider-google-beta](https://github.com/terraform-providers/terraform-provider-google-beta) 2.5

### Permissions

In order to execute this module you must have a Service Account with an appropriate role to manage IAM for the applicable resource. The appropriate role differs depending on which resource you are targeting, as follows:

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
    compute.subnetworks..setIamPolicy permissions.
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

## Development

### Requirements

- [docker](https://www.docker.com/) v18.XX

### Integration Tests

Integration tests are run though
[test-kitchen](https://github.com/test-kitchen/test-kitchen),
[kitchen-terraform](https://github.com/newcontext-oss/kitchen-terraform), and
[InSpec](https://github.com/inspec/inspec).

#### Test Setup

1. Configure the test fixtures
    ```
    cp test/fixtures/full/terraform.tfvars.example test/fixtures/full/terraform.tfvars
    # Edit copied var file.
    ```
2. Download a Service Account key with the necessary [permissions](#permissions)
   and put it in the module's root directory with the name `credentials.json`.
3. Build the Docker containers for testing.
    ```
    CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE="credentials.json" make docker_build_terraform
    CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE="credentials.json" make docker_build_kitchen_terraform
    ```
4. Run the testing container in interactive mode.
    ```
    make docker_run
    ```

    The module root directory will be loaded into the Docker container at `/cftk/workdir/`.
5. Run kitchen-terraform to test the infrastructure.

    1. `kitchen create` creates Terraform state.
    2. `kitchen converge` creates the underlying resources to later attach bindings to.
    3. `mv test/fixtures/full/iam.tf.mv test/fixtures/full/iam.tf` activate bindings.
    4. `kitchen create` re-init terraform plugins.
    5. `kitchen converge` apply IAM bindings.
    6. `kitchen verify` tests the created infrastructure.
    7. `kitchen destroy` remove all test fixtures.

NOTE: Steps 3-5 are needed because the IAM terraform resources rely on computed values from the resources that are to have the bindings applied.

Alternatively, you can simply run `make test_integration_docker` to run all the
test steps non-interactively.

### Autogeneration of documentation from .tf files

Run
```
make generate_docs
```

### Linting

The makefile in this project will lint or sometimes just format any shell,
Python, golang, Terraform, or Dockerfiles. The linters will only be run if
the makefile finds files with the appropriate file extension.

All of the linter checks are in the default make target, so you just have to
run

```
make -s
```

The -s is for 'silent'. Successful output looks like this

```
Running shellcheck
Running flake8
Running gofmt
Running terraform validate
Running hadolint on Dockerfiles
Test passed - Verified all file Apache 2 headers
```

The linters
are as follows:
* Shell - shellcheck. Can be found in homebrew
* Python - flake8. Can be installed with 'pip install flake8'
* Golang - gofmt. gofmt comes with the standard golang installation. golang
is a compiled language so there is no standard linter.
* Terraform - terraform has a built-in linter in the 'terraform validate'
command.
* Dockerfiles - hadolint. Can be found in homebrew
