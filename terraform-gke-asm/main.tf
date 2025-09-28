module "cluster" {
  source       = "git::https://github.com/lionelsakoue/gke-module.git//modules/cluster?ref=master"
  project_id   = var.project_id
  region       = var.region
  zone         = var.zone
  cluster_name = var.cluster_name
}

module "asm" {
  source        = "git::https://github.com/lionelsakoue/gke-module.git//modules/asm?ref=master"
  namespace     = var.namespace
  istio_version = var.istio_version
}

module "ingress" {
  source        = "git::https://github.com/lionelsakoue/gke-module.git//modules/ingress?ref=master"
  namespace     = var.namespace
  istio_version = var.istio_version
  depends_on    = [module.asm]
}

# Root-level outputs
output "cluster_name" {
  value = module.cluster.cluster_name
}

output "asm_status" {
  value = module.asm.istiod_status
}

output "ingress_status" {
  value = module.ingress.ingress_gateway_status
}
