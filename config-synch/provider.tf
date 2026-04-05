terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}


provider "google" {
  project = "practice-422202"
  region  = "us-central1"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}