resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  # Regional cluster = HA control plane across 3 zones
  node_locations = [
    "${var.region}-a",
    "${var.region}-b",
    "${var.region}-c"
  ]

  # Remove default node pool — we manage our own
  remove_default_node_pool = true
  initial_node_count       = 1

  min_master_version = var.kubernetes_version

  network    = "default"
  subnetwork = "default"

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    disk_size_gb = 100
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      env     = "dev"
      cluster = var.cluster_name
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}