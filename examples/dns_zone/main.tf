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
  Module dns_zone_iam_binding calling
 *********************************************/
module "dns_zones_iam_binding" {
  source  = "../../modules/dns_zones_iam/"
  project = var.project_id
  managed_zones = [
    google_dns_managed_zone.dns_zone_one.name,
  ]
  mode = "authoritative"

  bindings = {
    "roles/viewer" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/dns.reader" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}

resource "google_dns_managed_zone" "dns_zone_one" {
  project  = var.project_id
  name     = "test-iam-dns-${random_id.test.hex}-one"
  dns_name = "example-${random_id.test.hex}.com."
}

resource "random_id" "test" {
  byte_length = 4
}
