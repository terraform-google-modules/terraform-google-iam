/**
 * Copyright 2024 Google LLC
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

resource "google_secure_source_manager_instance" "default" {
  location    = "us-central1"
  instance_id = "ssm-instance"
  project     = var.project_id
}

resource "google_secure_source_manager_repository" "default" {
  project       = var.project_id
  location      = "us-central1"
  repository_id = "ssm-repo1"
  instance      = google_secure_source_manager_instance.default.name

  description = "test repository"
  initial_config {
    default_branch = "main"
  }
}

module "ssm_instance_iam_binding" {
  source  = "terraform-google-modules/iam/google//modules/secure_source_manager_iam"
  version = "~> 8.0"

  project  = var.project_id
  location = "us-central1"

  entity_ids = {
    instance_ids = [google_secure_source_manager_instance.default.instance_id]
  }

  mode = "additive"

  bindings = {
    "roles/securesourcemanager.instanceAccessor" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/securesourcemanager.instanceManager" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }

  depends_on = [google_secure_source_manager_instance.default]
}

module "ssm_repository_iam_binding" {
  source  = "terraform-google-modules/iam/google//modules/secure_source_manager_iam"
  version = "~> 8.0"

  project  = var.project_id
  location = "us-central1"

  entity_ids = {
    repository_ids = [google_secure_source_manager_repository.default.repository_id]
  }

  mode = "additive"

  bindings = {
    "roles/securesourcemanager.repoReader" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/securesourcemanager.repoWriter" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }

  depends_on = [google_secure_source_manager_repository.default]
}
