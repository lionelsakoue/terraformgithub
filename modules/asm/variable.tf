variable "namespace" {
  type        = string
  description = "Namespace for Istio control plane"
  default     = "istio-system"
}

variable "istio_version" {
  type        = string
  description = "Istio version to install"
  default     = "1.22.0"
}
