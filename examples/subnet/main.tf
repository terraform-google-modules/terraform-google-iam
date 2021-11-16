/**
 * Copyright 2019 Google LLC
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
  Module pubsub_subscription_iam_binding calling
 *****************************************/
module "subnet_iam_binding" {
  source = "../../modules/subnets_iam"

  subnets        = [local.subnet_one_full, local.subnet_two_full]
  subnets_region = var.region
  project        = var.project
  mode           = "authoritative"
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

