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
  Module tag_values_iam_binding calling
 *********************************************/
module "tag_values_iam_binding" {
  source = "../../modules/tag_values_iam/"
  tag_values = [
    google_tags_tag_value.tag_value.name,
  ]
  mode = "authoritative"

  bindings = {
    "roles/viewer" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_tags_tag_key" "tag_key" {
  parent      = "projects/${data.google_project.project.number}"
  short_name  = "foo1"
  description = "test tags"
}

resource "google_tags_tag_value" "tag_value" {
  parent      = "tagKeys/${google_tags_tag_key.tag_key.name}"
  short_name  = "bar1"
  description = "Tag value bar."
}
