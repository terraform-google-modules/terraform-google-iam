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

/******************************************
  Module pubsub_subscription_iam_binding calling
 *****************************************/
module "pubsub_subscription_iam_binding" {
  source               = "../../modules/pubsub_subscriptions_iam/"
  project              = var.pubsub_subscription_project
  pubsub_subscriptions = [var.pubsub_subscription_one, var.pubsub_subscription_two]
  mode                 = "additive"

  bindings = {
    "roles/pubsub.viewer" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/pubsub.editor" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}
