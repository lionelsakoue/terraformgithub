terraform {
  backend "gcs" {
    bucket = "tfstate-1884"   # Change to your GCS bucket name
    prefix = "gke-asm"             # Folder path inside the bucket
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.1.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
