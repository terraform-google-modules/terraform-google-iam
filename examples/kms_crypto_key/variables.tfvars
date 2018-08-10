/* *****************************************
https://cloud.google.com/iam/docs/understanding-roles
https://cloud.google.com/kms/docs/reference/permissions-and-roles

Grants Permissions:
- Owner role = Full access to all resources.
- Cloud KMS Admin role: Enables management of cryptoresources.
- Custom role: Add cloudkms.cryptoKeys.getIamPolicy	and
  cloudkms.cryptoKeys.setIamPolicy permissions.
***************************************** */

# kms_crypto_key_iam_binding
credentials_file_path = "/vagrant/terraform4.json"

kms_crypto_key_one = "projects/man-project-200917/locations/global/keyRings/man-key-ring/cryptoKeys/man-crypto-key"

kms_crypto_key_two = "projects/man-project-200917/locations/global/keyRings/man-key-ring-1/cryptoKeys/key-name-1"
