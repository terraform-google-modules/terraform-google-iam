/**
 * Copyright 2022 Google LLC
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

# /******************************************
#   Module tasks_queue_iam_member calling
#  *****************************************/
module "tasks_queue_iam_member" {
  source       = "../../modules/tasks_queue_iam"
  project      = var.tasks_queue_project
  tasks_queues = [var.tasks_queue_one, var.tasks_queue_two]
  location     = var.tasks_queue_location
  mode         = "additive"

  bindings = {
    "roles/cloudtasks.enqueuer" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}
