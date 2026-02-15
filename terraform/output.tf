output "gcs_bucket_name" {
  value       = google_storage_bucket.datalake.name
  description = "GCS bucket name (data lake)"
}

output "bq_raw_dataset" {
  value       = google_bigquery_dataset.raw.dataset_id
  description = "BigQuery raw dataset id"
}

output "bq_staging_dataset" {
  value       = google_bigquery_dataset.staging.dataset_id
  description = "BigQuery staging dataset id"
}

output "bq_marts_dataset" {
  value       = google_bigquery_dataset.marts.dataset_id
  description = "BigQuery marts dataset id"
}

output "gcs_raw_prefix" {
  value       = "gs://${google_storage_bucket.datalake.name}/raw/"
  description = "Raw prefix for landed files"
}
    