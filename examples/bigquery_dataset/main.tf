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

/*********************************************
  Module bigquery_dataset_iam_binding calling
 *********************************************/
module "bigquery_dataset_iam_binding" {
  source  = "../../modules/bigquery_datasets_iam/"
  project = var.project_id
  bigquery_datasets = [
    google_bigquery_dataset.bigquery_dataset_one.dataset_id,
  ]
  mode = "authoritative"

  bindings = {
    "roles/bigquery.dataViewer" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/bigquery.dataEditor" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}

resource "google_bigquery_dataset" "bigquery_dataset_one" {
  project    = var.project_id
  dataset_id = "test_iam_ds_${random_id.test.hex}_one"
}

resource "random_id" "test" {
  byte_length = 4
}
