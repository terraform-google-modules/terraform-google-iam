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

/******************************************
  Module cloud_run_v2_jobs_iam calling
 *****************************************/

module "cloud_run_v2_jobs_iam" {
  source  = "terraform-google-modules/iam/google//modules/cloud_run_v2_jobs_iam"
  version = "~> 8.0"

  project        = var.project
  location       = var.location
  cloud_run_jobs = [var.cloud_run_job_one, var.cloud_run_job_two]
  mode           = "authoritative"

  bindings = {
    "roles/run.invoker" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/run.viewer" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}
