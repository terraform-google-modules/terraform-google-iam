# Contributing

This document provides guidelines for contributing to the module.

## File structure

The project has the following folders and files:

- /: root folder.
- /examples: examples for using this module.
- /scripts: Scripts for specific tasks on module (see Infrastructure section on this file).
- /test: Folders with files for testing the module (see Testing section on this file).
- /main.tf: main file for this module, contains all the variables for operate the module.
- /modules: modules to manage the IAM bindings for each resource type.
- /variables.tf: all the variables for the module.
- /output.tf: the outputs of the module.
- /readme.MD: this file.

## Testing and documentation generation

### Requirements
- [Docker Engine][docker-engine]
- [Google Cloud SDK][google-cloud-sdk]
- [make]

### Integration testing
##### Terraform integration tests

Integration tests are used to verify the behaviour of the root module,
submodules, and example modules. Additions, changes, and fixes should
be accompanied with tests.

The integration tests are run using [Kitchen][kitchen],
[Kitchen-Terraform][kitchen-terraform], and [InSpec][inspec]. These
tools are packaged within a Docker image for convenience.

The general strategy for these tests is to verify the behaviour of the
[example modules](./examples/), thus ensuring that the root module,
submodules, and example modules are all functionally correct.

### Test Environment
The easiest way to test the module is in an isolated test project. The setup for such a project is defined in [test/setup](./test/setup/) directory.

To use this setup, you need a service account with Project Creator access on a folder. Export the Service Account credentials to your environment like so:

```
export SERVICE_ACCOUNT_JSON=$(< credentials.json)
```

You will also need to set a few environment variables:
```
export TF_VAR_org_id="your_org_id"
export TF_VAR_folder_id="your_folder_id"
export TF_VAR_billing_account="your_billing_account_id"
```

With these settings in place, you can prepare a test project using Docker:
```
make docker_test_prepare
```

### Noninteractive Execution

Run `make docker_test_integration` to test all of the example modules
noninteractively, using the prepared test project.

### Interactive Execution

1. Run `make docker_run` to start the testing Docker container in
   interactive mode.

1. Run `kitchen_do create <EXAMPLE_NAME>` to initialize the working
   directory for an example module.

1. Run `kitchen_do converge <EXAMPLE_NAME>` to apply the example module.

1. Run `kitchen_do verify <EXAMPLE_NAME>` to test the example module.

1. Run `kitchen_do destroy <EXAMPLE_NAME>` to destroy the example module
   state.

### Autogeneration of documentation from .tf files

Run
```
make generate_docs
```

### Lint testing

Lint testing is also performed within a Docker container containing all the
dependencies required for lint tests. Execute those tests by running `make
docker_test_lint` from the root of the repository.

Successful output looks similar to the following:

```
Checking for documentation generation
Checking for trailing whitespace
Checking for missing newline at end of file
Running shellcheck
Checking file headers
Running flake8
Running terraform fmt
terraform fmt -diff -check=true -write=false .
terraform fmt -diff -check=true -write=false ./examples/folder
terraform fmt -diff -check=true -write=false ./examples/kms_crypto_key
terraform fmt -diff -check=true -write=false ./examples/kms_key_ring
terraform fmt -diff -check=true -write=false ./examples/organization
terraform fmt -diff -check=true -write=false ./examples/project
terraform fmt -diff -check=true -write=false ./examples/pubsub_subscription
terraform fmt -diff -check=true -write=false ./examples/pubsub_topic
terraform fmt -diff -check=true -write=false ./examples/service_account
terraform fmt -diff -check=true -write=false ./examples/stackdriver_agent_roles
terraform fmt -diff -check=true -write=false ./examples/storage_bucket
terraform fmt -diff -check=true -write=false ./examples/subnet
terraform fmt -diff -check=true -write=false ./modules/folders_iam
terraform fmt -diff -check=true -write=false ./modules/kms_crypto_keys_iam
terraform fmt -diff -check=true -write=false ./modules/kms_key_rings_iam
terraform fmt -diff -check=true -write=false ./modules/organizations_iam
terraform fmt -diff -check=true -write=false ./modules/projects_iam
terraform fmt -diff -check=true -write=false ./modules/pubsub_subscriptions_iam
terraform fmt -diff -check=true -write=false ./modules/pubsub_topics_iam
terraform fmt -diff -check=true -write=false ./modules/service_accounts_iam
terraform fmt -diff -check=true -write=false ./modules/storage_buckets_iam
terraform fmt -diff -check=true -write=false ./modules/subnets_iam
terraform fmt -diff -check=true -write=false ./test/fixtures/full
terraform fmt -diff -check=true -write=false ./test/fixtures/full/base
terraform fmt -diff -check=true -write=false ./test/setup
Running terraform validate
terraform_validate .
Success! The configuration is valid.

terraform_validate ./examples/folder
Success! The configuration is valid.

terraform_validate ./examples/kms_crypto_key
Success! The configuration is valid.

terraform_validate ./examples/kms_key_ring
Success! The configuration is valid.

terraform_validate ./examples/organization
Success! The configuration is valid.

terraform_validate ./examples/project
Success! The configuration is valid.

terraform_validate ./examples/pubsub_subscription
Success! The configuration is valid.

terraform_validate ./examples/pubsub_topic
Success! The configuration is valid.

terraform_validate ./examples/service_account
Success! The configuration is valid.

terraform_validate ./examples/stackdriver_agent_roles
Success! The configuration is valid.

terraform_validate ./examples/storage_bucket
Success! The configuration is valid.

terraform_validate ./examples/subnet
Success! The configuration is valid.

terraform_validate ./modules/folders_iam
Success! The configuration is valid.

terraform_validate ./modules/kms_crypto_keys_iam
Success! The configuration is valid.

terraform_validate ./modules/kms_key_rings_iam
Success! The configuration is valid.

terraform_validate ./modules/organizations_iam
Success! The configuration is valid.

terraform_validate ./modules/projects_iam
Success! The configuration is valid.

terraform_validate ./modules/pubsub_subscriptions_iam
Success! The configuration is valid.

terraform_validate ./modules/pubsub_topics_iam
Success! The configuration is valid.

terraform_validate ./modules/service_accounts_iam
Success! The configuration is valid.

terraform_validate ./modules/storage_buckets_iam
Success! The configuration is valid.

terraform_validate ./modules/subnets_iam
Success! The configuration is valid.

terraform_validate ./test/fixtures/full
Success! The configuration is valid.

terraform_validate ./test/fixtures/full/base
Success! The configuration is valid.

terraform_validate ./test/setup
Success! The configuration is valid.
```

[docker-engine]: https://www.docker.com/products/docker-engine
[flake8]: http://flake8.pycqa.org/en/latest/
[gofmt]: https://golang.org/cmd/gofmt/
[hadolint]: https://github.com/hadolint/hadolint
[inspec]: https://inspec.io/
[kitchen-terraform]: https://github.com/newcontext-oss/kitchen-terraform
[kitchen]: https://kitchen.ci/
[make]: https://en.wikipedia.org/wiki/Make_(software)
[shellcheck]: https://www.shellcheck.net/
[terraform-docs]: https://github.com/segmentio/terraform-docs
[terraform]: https://terraform.io/
