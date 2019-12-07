# Upgrading to IAM 3.0

The 3.0 release of IAM is a backward incompatible release.

## Details

Prior to the 3.0 release, IAM could only support applying bindings to
static variable values due to the use of those values in the `count`
argument of resources.

For example, the following two configurations attempt to apply bindings
to projects; the first would work while the second would fail.

```hcl
# This does work with IAM 2.0

module "iam" {
  source  = "terraform-google-modules/iam/google"
  version = "~> 2.0"

  projects = ["project-123456"]

  bindings = {
    "roles/storage.admin" = [
      "serviceAccount:a-service-account@cft.tips",
    ]
  }
}
```

```hcl
# This does not work with IAM 2.0

module "project_factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 3.2"

  billing_account = "a-billing-account"
  name            = "iam-test"
  org_id          = "an-org"

  random_project_id = true
}

module "iam" {
  source  = "terraform-google-modules/iam/google"
  version = "~> 2.0"

  projects = [module.project_factory.project_id]

  bindings = {
    "roles/storage.admin" = [
      "serviceAccount:${module.project_factory.service_account_email}",
    ]
  }
}
```

The 3.0 release of IAM redesigned the internals of the module and added
some additional variables to support this use case.

## Upgrade Instructions

We recommend using individual bindings target submodules that can be invoked
directly. The following configurations highlight the approach in 3.0:

```diff
 module "iam" {
-  source  = "terraform-google-modules/iam/google"
+  source  = "terraform-google-modules/iam/google//modules/projects_iam"
-  version = "~> 2.0"
+  version = "~> 3.0"

   projects = ["project-123456"]

   bindings = {
     "roles/storage.admin" = [
       "serviceAccount:a-service-account@cft.tips",
     ]
   }
 }
```

Additionally, to support cases where dynamic values
are used to define the bindings or the bindings targets, number
variables are available to provide a static count of the contents, e.g.
`projects_num` and `bindings_num`. Both `*_num` variables must be used
regardless of which variable contains the dynamic content:

```diff
 module "project_factory" {
   source  = "terraform-google-modules/project-factory/google"
   version = "~> 3.2"

   billing_account = "a-billing-account"
   name            = "iam-test"
   org_id          = "an-org"

   random_project_id = true
 }

 module "iam" {
-  source  = "terraform-google-modules/iam/google"
+  source  = "terraform-google-modules/iam/google//modules/projects_iam"
-  version = "~> 2.0"
+  version = "~> 3.0"

   projects = [module.project_factory.project_id]

+  projects_num = 1

   bindings = {
     "roles/storage.admin" = [
       "serviceAccount:${module.project_factory.service_account_email}",
     ]
   }

+  bindings_num = 1
 }
```

Alternatively, you can use a root module where generic `bindings` variable has
 been replaced with resource-specific variables, like `projects_bindings` or
`folders_bindings`. To continue from the previous example, the following
configurations highlight the changes required to upgrade the module to 3.0:

```diff
 module "iam" {
   source  = "terraform-google-modules/iam/google"
-  version = "~> 2.0"
+  version = "~> 3.0"

   projects = ["project-123456"]

-  bindings = {
+  projects_bindings = {
     "roles/storage.admin" = [
       "serviceAccount:a-service-account@cft.tips",
     ]
   }

+  pubsub_topics_bindings = {}
+  pubsub_subscriptions_bindings = {}
+  storage_buckets_bindings = {}
+  subnets_bindings = {}
+  subnets_region = ""
+  organizations_bindings = {}
+  kms_crypto_keys_bindings = {}
+  kms_key_rings_bindings = {}
+  service_accounts_bindings = {}
+  folders_bindings = {}
 }
```

In case of dynamic values are used to define the bindings or the bindings
targets, number variables, e.g. `projects_num` and `projects_bindings_num`,
are available to provide a static count of the contents. Both `*_num`
variables must be used regardless of which variable contains the
dynamic content:

```diff
 module "project_factory" {
   source  = "terraform-google-modules/project-factory/google"
   version = "~> 3.2"

   billing_account = "a-billing-account"
   name            = "iam-test"
   org_id          = "an-org"

   random_project_id = true
 }

 module "iam" {
   source  = "terraform-google-modules/iam/google"
-  version = "~> 2.0"
+  version = "~> 3.0"

   projects = [module.project_factory.project_id]

+  projects_num = 1

-  bindings = {
+  projects_bindings = {
     "roles/storage.admin" = [
       "serviceAccount:${module.project_factory.service_account_email}",
     ]
   }

+  projects_bindings_num = 1

+  pubsub_topics_bindings = {}
+  pubsub_subscriptions_bindings = {}
+  storage_buckets_bindings = {}
+  subnets_bindings = {}
+  subnets_region = ""
+  organizations_bindings = {}
+  kms_crypto_keys_bindings = {}
+  kms_key_rings_bindings = {}
+  service_accounts_bindings = {}
+  folders_bindings = {}
 }
```
