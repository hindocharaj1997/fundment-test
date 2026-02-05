# GCS Datalake Bucket
resource "google_storage_bucket" "datalake_bucket" {
  name                        = var.datalake_bucket
  location                    = var.region
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

# BigQuery Datasets

resource "google_bigquery_dataset" "bronze_dataset" {
  dataset_id  = var.bronze_dataset
  location    = var.region
  description = "Bronze Dataset"
}

resource "google_bigquery_dataset" "silver_dataset" {
  dataset_id  = var.silver_dataset
  location    = var.region
  description = "Silver Dataset"
}

resource "google_bigquery_dataset" "gold_dataset" {
  dataset_id  = var.gold_dataset
  location    = var.region
  description = "Gold Dataset"
}

# Bronze BigQuery Table (Raw)

resource "google_bigquery_table" "fees_raw" {

  dataset_id           = google_bigquery_dataset.bronze_dataset.dataset_id
  table_id             = "fees_raw"

  schema = jsonencode([
    { name = "client_id", type = "STRING", mode = "REQUIRED" },
    { name = "client_nino", type = "STRING", mode = "REQUIRED" },
    { name = "adviser_id", type = "STRING", mode = "REQUIRED" },
    { name = "fee_date", type = "DATE", mode = "REQUIRED" },
    { name = "fee_amount", type = "NUMERIC", mode = "REQUIRED" }
  ])
}

# Silver BigQuery Table (Cleaned)

resource "google_bigquery_table" "fees_clean" {

  dataset_id           = google_bigquery_dataset.silver_dataset.dataset_id
  table_id             = "fees_clean"
  deletion_protection  = false

  schema = jsonencode([
    { name = "client_id", type = "STRING", mode = "REQUIRED" },
    { name = "client_nino", type = "STRING", mode = "REQUIRED" },
    { name = "adviser_id", type = "STRING", mode = "REQUIRED" },
    { name = "fee_date", type = "DATE", mode = "REQUIRED" },
    { name = "fee_amount", type = "NUMERIC", mode = "REQUIRED" },
    { name = "first_fee_date", type = "DATE", mode = "REQUIRED" },
    { name = "month_number", type = "INTEGER", mode = "REQUIRED" }
  ])
}

# Gold BigQuery Table (Aggregated)

resource "google_bigquery_table" "client_ltv" {

  dataset_id           = google_bigquery_dataset.gold_dataset.dataset_id
  table_id             = "client_ltv"
  deletion_protection  = false

  schema = jsonencode([
    { name = "client_id", type = "STRING", mode = "REQUIRED" },
    { name = "cohort_month", type = "INTEGER", mode = "REQUIRED" },
    { name = "cohort_year", type = "INTEGER", mode = "REQUIRED" },
    { name = "ltv_1m", type = "NUMERIC", mode = "REQUIRED" },
    { name = "ltv_3m", type = "NUMERIC", mode = "REQUIRED" },
    { name = "ltv_6m", type = "NUMERIC", mode = "REQUIRED" }
  ])
}

resource "google_bigquery_table" "adviser_ltv" {

  dataset_id           = google_bigquery_dataset.gold_dataset.dataset_id
  table_id             = "adviser_ltv"
  deletion_protection  = false

  schema = jsonencode([
    { name = "adviser_id", type = "STRING", mode = "REQUIRED" },
    { name = "total_6m_ltv", type = "NUMERIC", mode = "REQUIRED" }
  ])
}
