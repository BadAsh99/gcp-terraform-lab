variable "gcp_project_id" {
  description = "The GCP Project ID to deploy resources in."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region."
  type        = string
  default     = "us-central1"
}

variable "gcp_zone" {
  description = "The GCP zone to deploy the VM in."
  type        = string
  default     = "us-central1-a"
}