/* *****************************************
https://cloud.google.com/iam/docs/understanding-roles
https://cloud.google.com/compute/docs/access/iam

Grants Permissions:
- Project owner role: Full access to all resources.
- Project compute admin: Full control of Compute Engine resources.
- Project compute network admin role: Full control of Compute Engine networking resources.
- Project custom role: Add compute.subnetworks.getIamPolicy	and
  compute.subnetworks..setIamPolicy permissions.
***************************************** */

# subnet_iam_binding
credentials_file_path = "/vagrant/terraform4.json"

subnet_one = "projects/man-project-200917/regions/us-central1/subnetworks/man-network"

subnet_two = "projects/man-project-200917/regions/europe-west1/subnetworks/man-network"
