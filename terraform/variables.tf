variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "asia-southeast1"
}

variable "location" {
  description = "Data location for BigQuery dataset & GCS bucket (e.g. ASIA-SOUTHEAST1)"
  type        = string
  default     = "ASIA-SOUTHEAST1"
}

variable "bucket_prefix" {
  description = "Prefix for GCS bucket name (unique suffix will be appended)"
  type        = string
  default     = "cuong-weather-datalake"
}

variable "raw_dataset_id" {
  description = "BigQuery dataset id for raw"
  type        = string
}

variable "staging_dataset_id" {
  description = "BigQuery dataset id for staging"
  type        = string
}

variable "marts_dataset_id" {
  description = "BigQuery dataset id for marts"
  type        = string
}

variable "force_destroy_bucket" {
  description = "If true, terraform destroy will delete bucket even if it contains objects"
  type        = bool
  default     = true
}

variable "bucket_lifecycle_delete_after_days" {
  description = "Delete objects older than N days. Set 0 to disable."
  type        = number
  default     = 30
}
