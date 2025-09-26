variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "Region for the cluster"
}

variable "zone" {
  type        = string
  description = "Zone for the cluster"
}

variable "cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
}
