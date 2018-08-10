/* *****************************************
https://cloud.google.com/iam/docs/understanding-roles
https://cloud.google.com/pubsub/docs/access-control

Grants Permissions:
- Pub/Sub Admin role: Create and manage service accounts.
- Custom role: Add pubsub.subscriptions.getIamPolicy and
  pubsub.subscriptions.setIamPolicy permissions.
***************************************** */

# pubsub_subscription_iam_binding
credentials_file_path = "/vagrant/terraform4.json"

pubsub_subscription_project = "man-project-200917"

pubsub_subscription_one = "man-subscription"

pubsub_subscription_two = "man-subscription-1"
