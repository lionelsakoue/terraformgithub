resource "google_gke_hub_feature_membership" "acm_gke_ha" {
  location   = "global"
  feature    = "configmanagement"
  membership = "gke-ha-cluster"
  membership_location = "us-central1"

  configmanagement {
    config_sync {
      enabled = true
    }
  }
}
