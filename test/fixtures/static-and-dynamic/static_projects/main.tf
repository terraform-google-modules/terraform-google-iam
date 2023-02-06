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

locals {
  mode_short = var.mode == "authoritative" ? "auth" : "add"

  static_project_ids = [
    for i in range(var.n)
    : "${var.prefix}-${local.mode_short}-st-${i}-${var.random_hexes[i]}"
  ]
}

resource "google_project" "test" {
  count = var.n

  project_id      = local.static_project_ids[count.index]
  folder_id       = var.folder_id
  name            = "Test IAM Project ${title(local.mode_short)} St ${count.index}"
  billing_account = var.billing_account
}
