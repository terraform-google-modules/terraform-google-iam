/**
 * Copyright 2019 Google LLC
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

output "service_account_addresses" {
  value       = [local.service_account_01_email, local.service_account_02_email]
  description = "Service Account Addresses which were bound to projects."
}

output "billing_account_ids" {
  value       = module.billing-account-iam.billing_account_ids
  description = "Billing Accounts which received bindings."
}

output "members" {
  value       = module.billing-account-iam.members
  description = "Members which were bound to the billing accounts."
}
