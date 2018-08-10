/* *****************************************
https://cloud.google.com/iam/docs/understanding-roles
https://cloud.google.com/resource-manager/docs/access-control-folders

Grants Permissions:
- The Folder Admin role: All available folder permissions.
- Folder IAM Admin role: Allows users to administer IAM policies on folders.
- Custom role: Add resourcemanager.folders.getIamPolicy and
  resourcemanager.folders.setIamPolicy permissions (must be added in the organization).
***************************************** */

# folder_iam_binding
credentials_file_path = "/vagrant/terraform4.json"

folder_one = "1024109644757"

folder_two = "558760296800"
