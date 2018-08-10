/* *****************************************
https://cloud.google.com/iam/docs/understanding-roles
https://cloud.google.com/resource-manager/docs/access-control-proj

Grants Permissions:
- Owner role: Full access and all permissions for all resources of the project.
- Projects IAM Admin role: allows users to administer IAM policies on projects.
- Custom role: Add resourcemanager.projects.getIamPolicy and
  resourcemanager.projects.setIamPolicy permissions.
***************************************** */

# project_iam_binding
credentials_file_path = "/vagrant/terraform4.json"

project_one = "man-project-200917"

project_two = "man1-project-203520"
