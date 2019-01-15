locals {
  n = 2
  prefix = "test-iam"
  location = "us-central1"
}

provider "google" {
  credentials = "${file(var.credentials_file_path)}"
}

provider "google-beta" {
  credentials = "${file(var.credentials_file_path)}"
}

# Folders

resource "google_folder" "test" {
  count = "${local.n}"

  display_name = "Test IAM Folder ${count.index}"
  parent = "organizations/${var.org_id}"
}

# Projects

resource "random_id" "test" {
  count = "${local.n}"

  byte_length = 2
}

resource "google_project" "test" {
  count = "${local.n}"

  project_id = "${local.prefix}-prj-${count.index}-${random_id.test.*.hex[count.index]}"
  org_id     = "${var.org_id}"
  billing_account = "${var.billing_account}"

  name = "Test IAM Project ${count.index}"
}

# Service Accounts

resource "google_service_account" "test" {
  count = "${local.n}"

  project = "${google_project.test.*.project_id[count.index]}"

  account_id = "${local.prefix}-svcacct-${count.index}-${random_id.test.*.hex[count.index]}"
}

# Buckets

resource "google_storage_bucket" "test" {
  count = "${local.n}"

  project = "${google_project.test.*.project_id[count.index]}"

  name     = "${local.prefix}-bkt-${count.index}-${random_id.test.*.hex[count.index]}"
}

# KMS

resource "google_project_service" "kms" {
  count = "${local.n}"

  project = "${google_project.test.*.project_id[count.index]}"
  service = "cloudkms.googleapis.com"
}

resource "google_kms_key_ring" "test" {
  count = "${local.n}"

  depends_on = ["google_project_service.kms"]

  project = "${google_project.test.*.project_id[count.index]}"
  
  name = "${local.prefix}-keyrng-${count.index}-${random_id.test.*.hex[count.index]}"
  location = "${local.location}"
}

resource "google_kms_crypto_key" "test" {
  count = "${local.n}"

  name = "${local.prefix}-key-${count.index}-${random_id.test.*.hex[count.index]}"

  key_ring = "${google_kms_key_ring.test.*.self_link[count.index]}"
}

# Pubsub

resource "google_pubsub_topic" "test" {
  count = "${local.n}"

  project = "${google_project.test.*.project_id[count.index]}"

  name = "${local.prefix}-tpc-${count.index}-${random_id.test.*.hex[count.index]}"
}

resource "google_pubsub_subscription" "test" {
  count = "${local.n}"

  project = "${google_project.test.*.project_id[count.index]}"

  topic = "${google_pubsub_topic.test.*.name[count.index]}"
  name = "${local.prefix}-sub-${count.index}-${random_id.test.*.hex[count.index]}"
}
