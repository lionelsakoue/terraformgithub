resource "google_gke_hub_feature_membership" "acm_gke_ha" {
  location   = "us-central1"
  feature    = "configmanagement"
  membership = "gke-ha-cluster"

  configmanagement {
    config_sync {
      enabled = true
    }
  }
}
