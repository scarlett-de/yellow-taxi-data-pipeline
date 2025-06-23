
variable "Credentials" {
  description = "My Credentials"
  default     = "./keys/my_creds.json"
}

variable "project" {
  description = "Project"
  default     = "modified-alloy-447921-n7"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

variable "region" {
  description = "Project region"
  default     = "us-east1"
}


variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "My Sotrage Bucket Name"
  default     = "bucket-modified-alloy-447921-n7"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}
