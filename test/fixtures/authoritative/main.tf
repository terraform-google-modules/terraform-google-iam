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

module "generic" {
  source          = "../helper"
  mode            = "authoritative"
  subnet_cidr     = ["192.168.1.0/24", "192.168.11.0/24"]
  folder_id       = var.folder_id
  billing_account = var.billing_account
  location        = var.location
  project_id      = var.project_id
  member1         = var.member1
  member2         = var.member2
  roles           = var.roles
}
