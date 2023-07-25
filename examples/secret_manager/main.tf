/**
 * Copyright 2021 Google LLC
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

/******************************************
  Module secret_iam_binding calling
 *****************************************/
module "folder-iam" {
  source  = "../../modules/secret_manager_iam"
  project = var.project_id
  secrets = [var.secret_one, var.secret_two]

  mode = "additive"

  bindings = {
    "roles/secretmanager.secretAccessor" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]

    "roles/secretmanager.viewer" = [
      "user:${var.user_email}",
    ]
  }
}
