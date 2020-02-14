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

output "project_id" {
  value = module.iam-project.project_id
}

output "sa_key" {
  value     = google_service_account_key.int_test.private_key
  sensitive = true
}

output "folder_id" {
  value = google_folder.ci-iam-folder.id
}

output "org_id" {
  value = var.org_id
}

output "billing_account" {
  value = var.billing_account
}

output "member1" {
  value       = google_service_account.member[0].email
  description = "Members created for binding with roles."
}

output "member2" {
  value       = google_service_account.member[1].email
  description = "Members created for binding with roles."
}

output "billing_sa_admin" {
  value       = google_service_account.int_test.email
  description = "Admin Service Account bound to Test Billing Account."
}

output "random_hexes" {
  value       = random_id.random_hexes[*].hex
  description = "List of pre-generated random id hexes. Required for 'for_each' to work when testing static scerarios."
}

output "billing_iam_test_account" {
  value       = var.billing_iam_test_account
  description = "The billing iam test account id is for the billing-iam-module, only for testing, e.g. XXXXXX-YYYYYY-ZZZZZZ"
}
