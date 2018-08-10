/* *****************************************
https://cloud.google.com/iam/docs/understanding-roles
https://cloud.google.com/pubsub/docs/access-control

Grants Permissions:
- Pub/Sub Admin role: Create and manage service accounts.
- Custom role: Add pubsub.topics.getIamPolicy and
  pubsub.topics.setIamPolicy permissions.
***************************************** */

# pubsub_topic_iam_binding
credentials_file_path = "/vagrant/terraform4.json"

pubsub_topic_project = "man-project-200917"

pubsub_topic_one = "man-topic"

pubsub_topic_two = "cloud-builds"
