resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
    labels = {
      istio-injection = "disabled" # control plane ns usually doesn’t auto-inject
    }
  }
}
