# Upgrading to IAM 4.0

The 4.0 release of IAM is a backward incompatible release.

## Details

The 3.0 release have added support for applying bindings to dynamic variable values. This functionality was relying on `count` which
in the end turned out to result in inconsistent module behavior
when doing the configuration updates.

Here is an example of such *dynamic* configuration in 3.0
which applies bindings to two projects.

```hcl
module "project_factory_0" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 3.2"

  billing_account = "a-billing-account"
  name            = "iam-test-0"
  org_id          = "an-org"

  random_project_id = true
}

module "project_factory_1" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 3.2"

  billing_account = "a-billing-account"
  name            = "iam-test-1"
  org_id          = "an-org"

  random_project_id = true
}

module "iam" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 3.0"

  projects = [module.project_factory_0.project_id, module.project_factory_1.project_id]
  projects_num = 2

  bindings = {
    "roles/storage.admin" = [
      "serviceAccount:${module.project_factory_0.service_account_email}",
      "serviceAccount:${module.project_factory_1.service_account_email}"
    ]
  }
  bindings_num = 2
}
```

Note that you have to specify the additional options which look like
they are redundant: `projects_num` and `bindings_num`. These
options had to be introduced in 3.0 to support the dynamic configuration
usecase. Internally it was bounded to the way `count` works in terraform.

Unfortunately, this led to issues when updating the configuration.
For example adding a new role at some later point and reapplying the
configuration was leading to breaking race-conditions in many cases.
And the most dangerous thing was that the terraform was claiming the
update to be fully successful, even though in reality you might have
ended up with several iam roles deleted by mistake.

The 4.0 release uses `for_each` instead of `count` everywhere and adds
additional rules for using dynamic variables in the module configuration.

As a side-effect, there is no need in extra `*_num` options.

The limitations of dynamic usecase are as follows:

1. Dynamic entities (for example `projects`) are only allowed for 1 entity.
2. If you pass 2 or more entities (for example `projects`), the configuration **MUST** be static, meaning that it can't use any of the other resources' fields to get the entity name from (this includes getting the randomly generated hashes through the `random_id` resource).
3. The role names themselves can never be dynamic.
4. Members may only be dynamic in `authoritative` mode.

## Upgrade Instructions

1. Remove all `*_num` variables.
2. If your entities list (`projects`, `buckets`, etc) contains dynamic values (like in the previous example), you have to split these dynamic values into separate `iam` modules. So in the example above we are going to end up with 2 `iam` modules, each having 1 dynamic project specified.
3. If you were generating role names themselves dynamically, it is no longer supported.
4. If you were using dynamic values for members in `additive` mode, this is no longer supported. You can still provide dynamic members in `authoritative` mode though.

To continue from the previous example, the following configurations
highlight the changes required to upgrade the module to 4.0.

```diff
 module "project_factory_0" {
   source  = "terraform-google-modules/project-factory/google"
   version = "~> 3.2"

   billing_account = "a-billing-account"
   name            = "iam-test-0"
   org_id          = "an-org"

   random_project_id = true
 }

 module "project_factory_1" {
   source  = "terraform-google-modules/project-factory/google"
   version = "~> 3.2"

   billing_account = "a-billing-account"
   name            = "iam-test-1"
   org_id          = "an-org"

   random_project_id = true
 }

 module "iam" {
   source  = "terraform-google-modules/iam/google//modules/projects_iam"
-  version = "~> 3.0"
+  version = "~> 4.0"

+  mode = "authoritative"
+
-  projects = [module.project_factory_0.project_id, module.project_factory_1.project_id]
+  projects = [module.project_factory_0.project_id]
-  projects_num = 2

   bindings = {
     "roles/storage.admin" = [
       "serviceAccount:${module.project_factory_0.service_account_email}",
       "serviceAccount:${module.project_factory_1.service_account_email}"
     ]
   }
-  bindings_num = 2
 }
+
+module "iam" {
+  source  = "terraform-google-modules/iam/google//modules/projects_iam"
+  version = "~> 4.0"
+
+  mode = "authoritative"
+
+  projects = [module.project_factory_1.project_id]
+
+  bindings = {
+    "roles/storage.admin" = [
+      "serviceAccount:${module.project_factory_0.service_account_email}",
+      "serviceAccount:${module.project_factory_1.service_account_email}"
+    ]
+  }
+}
```

Note that we had to split `iam` configuration into 2 and force the
`authoritative` mode to be able to specify a member dynamically.

If your configuration is fully static, you will only need to remove
the `*_num` options and everything should work as it was before. Static
configuration still allows for multiple entities specified in the
according options (`projects`, `buckets`, etc).
