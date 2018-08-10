/* *****************************************
https://cloud.google.com/iam/docs/understanding-roles

Grants Permissions:
- Service Account Admin role can create and manage service accounts.
- Custom role: Add resourcemanager.organizations.getIamPolicy and
  resourcemanager.organizations.setIamPolicy permissions.
***************************************** */

# service_account_iam_binding
credentials_file_path = "/vagrant/terraform4.json"

service_account_project = "man-project-200917"

service_account_one = "man-sa@man-project-200917.iam.gserviceaccount.com"

service_account_two = "sa-155@man-project-200917.iam.gserviceaccount.com"
