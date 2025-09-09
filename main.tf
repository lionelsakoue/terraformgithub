terraform {
  required_version = ">= 1.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.1.0"
    }
  }
}

provider "google" {
  project = "practice-422202"   # Your GCP project ID
  region  = "us-east1"          # Updated region
  zone    = "us-east1-b"        # Zone inside us-east1
}

resource "google_compute_instance" "ubuntu_vm" {
  name         = "ubuntu-vm"
  machine_type = "e2-medium"   # 2 vCPU, 4GB RAM
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      # This gives the VM a public IP
    }
  }
}
