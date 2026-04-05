terraform {
  backend "gcs" {
    bucket = "tfstate-1884"
    prefix = "gke/state"
  }
}