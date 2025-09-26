module "cluster" {
  source       = "../modules/cluster"
  project_id   = var.project_id
  region       = var.region
  zone         = var.zone
  cluster_name = var.cluster_name
}

# Wait for cluster + nodes to be Ready
resource "null_resource" "gke_ready" {
  depends_on = [module.cluster]

  provisioner "local-exec" {
    command = <<EOT
      gcloud container clusters get-credentials ${module.cluster.cluster_name} \
        --zone ${var.zone} \
        --project ${var.project_id}

      # Wait until all nodes are Ready
      kubectl wait --for=condition=Ready nodes --all --timeout=300s
    EOT
  }
}

module "asm" {
  source        = "../modules/asm"
  namespace     = "istio-system"
  istio_version = "1.22.0"

  depends_on = [null_resource.gke_ready]
}

module "ingress" {
  source       = "../modules/ingress"
  cluster_name = module.cluster.cluster_name
  namespace    = "istio-system"

  depends_on = [module.asm]
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

