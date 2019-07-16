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

output "projects" {
  value       = google_project.test.*.project_id
  description = "Projects created for bindings."
}

output "folders" {
  value = [
    replace(google_folder.test[0].name, "folders/", ""),
    replace(google_folder.test[1].name, "folders/", ""),
  ]

  description = "Folders created for bindings."
}

output "service_accounts" {
  value       = google_service_account.test.*.email
  description = "Service accounts created for bindings."
}

output "members" {
  value       = google_service_account.member.*.email
  description = "Members created for binding with roles."
}

output "buckets" {
  value       = google_storage_bucket.test.*.name
  description = "Storage buckets created for bindings."
}

output "key_rings" {
  value       = google_kms_key_ring.test.*.self_link
  description = "Key rings created for bindings."
}

output "keys" {
  value       = google_kms_crypto_key.test.*.self_link
  description = "Crypto keys created for bindings."
}

output "topics" {
  value       = google_pubsub_topic.test.*.name
  description = "Pubsub topics created for bindings."
}

output "subscriptions" {
  value       = google_pubsub_subscription.test.*.name
  description = "Pubsub subscriptions created for bindings."
}

