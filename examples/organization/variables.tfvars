/* *****************************************
https://cloud.google.com/iam/docs/understanding-roles
https://cloud.google.com/resource-manager/docs/access-control-org

Grants Permissions:
- Owner: All permissions for edit, manage roles, project and all
  resources within the project and get up billing for a project.
- Organization Administrator: Access to administer all resources belonging to the organization.
  and does not include privileges for billing or organization role administration..
- Custom role: Add resourcemanager.organizations.getIamPolicy and
  resourcemanager.organizations.setIamPolicy permissions.
***************************************** */

# project_iam_binding
credentials_file_path = "/vagrant/terraform4.json"

organization_one = "65779779009"

organization_two = ""