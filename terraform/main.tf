resource "random_id" "suffix" {
  byte_length = 3
}

provider "google" {
  project = var.project_id
  region  = var.region
  #     
}

# ---------
# GCS bucket (Data Lake)
# ---------
resource "google_storage_bucket" "datalake" {
  name          = "${var.bucket_prefix}-${random_id.suffix.hex}"
  location      = var.location
  force_destroy = var.force_destroy_bucket

  uniform_bucket_level_access = true

  dynamic "lifecycle_rule" {
    for_each = var.bucket_lifecycle_delete_after_days > 0 ? [1] : []
    content {
      condition { age = var.bucket_lifecycle_delete_after_days }
      action    { type = "Delete" }
    }
  }
}

# Optional prefixes (cho dễ nhìn trong UI)
resource "google_storage_bucket_object" "raw_prefix" {
  name    = "raw/"
  content = "prefix"
  bucket  = google_storage_bucket.datalake.name
}

resource "google_storage_bucket_object" "checkpoint_prefix" {
  name    = "checkpoint/"
  content = "prefix"
  bucket  = google_storage_bucket.datalake.name
}

resource "google_storage_bucket_object" "logs_prefix" {
  name    = "logs/"
  content = "prefix"
  bucket  = google_storage_bucket.datalake.name
}

# ---------
# BigQuery datasets
# ---------
resource "google_bigquery_dataset" "raw" {
  dataset_id = var.raw_dataset_id
  location   = lower(var.location) == "asia-southeast1" ? "asia-southeast1" : var.location
  delete_contents_on_destroy = true
}

resource "google_bigquery_dataset" "staging" {
  dataset_id = var.staging_dataset_id
  location   = lower(var.location) == "asia-southeast1" ? "asia-southeast1" : var.location
  delete_contents_on_destroy = true
}

resource "google_bigquery_dataset" "marts" {
  dataset_id = var.marts_dataset_id
  location   = lower(var.location) == "asia-southeast1" ? "asia-southeast1" : var.location
  delete_contents_on_destroy = true
}
