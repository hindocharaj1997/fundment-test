variable "project" {
    type = string
    default = "pocs19"
    description = "GCP Project ID"
}

variable "region" {
    type = string
    default = "us-south1"
    description = "GCP Region"
}

variable "datalake_bucket" {
    type = string
    default = "fundment-datalake"
    description = "GCP Datalake Bucket Name"
}

variable "bronze_dataset" {
  type    = string
  default = "bronze"
}

variable "silver_dataset" {
  type    = string
  default = "silver"
}

variable "gold_dataset" {
  type    = string
  default = "gold"
}