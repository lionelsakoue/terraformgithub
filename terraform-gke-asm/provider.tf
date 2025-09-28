terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.29.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }
  }
}

# Google provider for cluster infra
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# Get current user credentials for cluster access
data "google_client_config" "default" {}

# Kubernetes provider (connects Terraform to your GKE cluster)
provider "kubernetes" {
  host                   = "https://${module.cluster.cluster_endpoint}"
  cluster_ca_certificate = base64decode(module.cluster.cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

# Helm provider (to install Istio/Ingress Gateways)
provider "helm" {
  kubernetes = {
    host                   = "https://${module.cluster.cluster_endpoint}"
    cluster_ca_certificate = base64decode(module.cluster.cluster_ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
}

