output "projects" {
  value = ["${google_project.test.*.project_id}"]
}

output "folders" {
  value = ["${google_folder.test.*.name}"]
}

output "service_accounts" {
  value = ["${google_service_account.test.*.email}"]
}

output "buckets" {
  value = ["${google_storage_bucket.test.*.name}"]
}

output "key_rings" {
  value = ["${google_kms_key_ring.test.*.self_link}"]
}
output "keys" {
  value = ["${google_kms_crypto_key.test.*.self_link}"]
}

output "topics" {
  value = ["${google_pubsub_topic.test.*.name}"]
}
output "subscriptions" {
  value = ["${google_pubsub_subscription.test.*.name}"]
}
