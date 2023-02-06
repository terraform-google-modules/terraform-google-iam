/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# Resources

#Additive

output "billing_iam_test_accounts" {
  value       = module.iam_binding_billing_accounts_additive.billing_account_ids
  description = "Billing Accounts which received bindings."
}

output "members" {
  value       = module.iam_binding_billing_accounts_additive.members
  description = "Members which were bound to the billing accounts."
}

output "project_id" {
  value       = var.project_id
  description = "Project ID"
}
