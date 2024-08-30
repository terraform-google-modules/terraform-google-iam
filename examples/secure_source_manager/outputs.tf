output "instance_id" {
  value       = google_secure_source_manager_instance.default.instance_id
  description = "SSM Instance ID"
}

output "repository_id" {
  value       = google_secure_source_manager_repository.default.repository_id
  description = "SSM repository ID"
}
