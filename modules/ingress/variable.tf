variable "cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
}

variable "namespace" {
  type        = string
  description = "Namespace for the ingress gateway"
  default     = "istio-system"
}
