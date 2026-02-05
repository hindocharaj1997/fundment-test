terraform {
    required_version = ">= 1.14.0"
    required_providers {
        google = {
            source  = "hashicorp/google"
            version = "~> 7.16"
        }
    }
}

provider "google" {
    project = "pocs19"
    region = "us-south1"
}
    