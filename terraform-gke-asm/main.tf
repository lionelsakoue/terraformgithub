module "cluster" {
  source       = "../modules/cluster"
  project_id   = var.project_id
  region       = var.region
  zone         = var.zone
  cluster_name = var.cluster_name
}

module "asm" {
  source        = "../modules/asm"
  namespace     = "istio-system"
  istio_version = "1.22.0"
}

module "ingress" {
  source     = "../modules/ingress"
  cluster_name = module.cluster.cluster_name
  namespace    = "istio-system"
}

# Root-level outputs
output "cluster_name" {
  value = module.cluster.cluster_name
}

output "asm_version" {
  value = module.asm.asm_version
}

output "asm_namespace" {
  value = module.asm.asm_namespace
}

output "ingress_namespace" {
  value = module.ingress.ingress_gateway_namespace
}
