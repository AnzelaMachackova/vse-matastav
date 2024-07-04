variable "credentials" {
  description = "My Credentials"
  default     = "/Users/anzelam/ac/google-vse/terraform/gcp-creds.json"
}

variable "project" {
  description = "Project"
  default     = "vse-matastav"
}

variable "region" {
  description = "Region"
  default     = "europe-west3-a"
}

variable "location" {
  description = "Project Location"
  default     = "EU"
}

variable "bq_dataset_name_L1" {
  description = "My BigQuery Dataset Name"
  default     = "L1"
}


variable "bq_dataset_name_L2" {
  description = "My BigQuery Dataset Name"
  default     = "L2"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "vse-matastav-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}