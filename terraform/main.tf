terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.6.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}


resource "google_storage_bucket" "vse-matastav_storage" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true


  lifecycle_rule {
    condition {
      age = 60
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}


resource "google_bigquery_dataset" "l1" {
  dataset_id = var.bq_dataset_name_l1
  location   = var.location
}

resource "google_bigquery_dataset" "report" {
  dataset_id = var.bq_dataset_name_report
  location   = var.location
}