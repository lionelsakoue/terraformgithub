resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
  }

  lifecycle {
    ignore_changes = all
  }
}
