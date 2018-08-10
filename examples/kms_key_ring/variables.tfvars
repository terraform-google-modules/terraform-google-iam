/* *****************************************
https://cloud.google.com/iam/docs/understanding-roles
https://cloud.google.com/kms/docs/reference/permissions-and-roles

Grants Permissions:
- Owner role = Full access to all resources.
- Cloud KMS Admin role: Enables management of crypto resources.
- Custom role: Add cloudkms.keyRings.getIamPolicy and
  cloudkms.keyRings.getIamPolicy permissions.
***************************************** */

# kms_key_ring_iam_binding
credentials_file_path = "/vagrant/terraform4.json"

kms_key_ring_one = "projects/man-project-200917/locations/global/keyRings/man-key-ring"

kms_key_ring_two = "projects/man-project-200917/locations/global/keyRings/man-key-ring-1"
