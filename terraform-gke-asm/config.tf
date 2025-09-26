terraform {
  backend "gcs" {
    bucket = "tfstate-1884"   # Change to your GCS bucket name
    prefix = "gke-asm"        # Folder path inside the bucket
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.31.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.13.0"
    }
  }
}

# Google provider
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# Get current user credentials
data "google_client_config" "default" {}

# Kubernetes provider wired to cluster outputs
provider "kubernetes" {
  host                   = module.cluster.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.cluster.ca_certificate)

  depends_on = [module.cluster]
}

# Helm provider wired the same way
provider "helm" {
  kubernetes {
    host                   = module.cluster.endpoint
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.cluster.ca_certificate)
  }

  depends_on = [module.cluster]
}
