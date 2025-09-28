terraform {
  backend "gcs" {
    bucket = "tfstate-1884"   # Change to your GCS bucket name
    prefix = "gke-asm"             # Folder path inside the bucket
  }
}
