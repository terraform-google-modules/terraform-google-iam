/* *****************************************
https://cloud.google.com/iam/docs/understanding-roles
https://cloud.google.com/storage/docs/access-control/iam

Grants Permissions:
- Storage Admin role: Full control of GCS resources.
- Storage Legacy Bucket Owner role: Read and write access to existing
  buckets with object listing/creation/deletion.
- Custom role: Add storage.buckets.getIamPolicy	and
  storage.buckets.setIamPolicy permissions.
***************************************** */

# storage_bucket_iam_binding
credentials_file_path = "/vagrant/terraform4.json"

storage_bucket_one = "man-bucket"

storage_bucket_two = "man-project-200917.appspot.com"
