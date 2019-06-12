/**
 * Copyright 2018 Google LLC
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
  credentials_file_path = var.credentials_file_path
  subnet_one_full = format(
    "projects/%s/regions/%s/subnetworks/%s",
    var.project,
    var.region,
    var.subnet_one,
  )
  subnet_two_full = format(
    "projects/%s/regions/%s/subnetworks/%s",
    var.project,
    var.region,
    var.subnet_two,
  )
}

/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  credentials = file(local.credentials_file_path)
  version     = "~> 2.7"
}

provider "google-beta" {
  credentials = file(local.credentials_file_path)
  version     = "~> 2.7"
}

/******************************************
  Module pubsub_subscription_iam_binding calling
 *****************************************/
module "subnet_iam_binding" {
  source = "../../"

  subnets = [local.subnet_one_full, local.subnet_two_full]

  mode = "authoritative"

  bindings = {
    "roles/compute.networkUser" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/compute.networkViewer" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}

