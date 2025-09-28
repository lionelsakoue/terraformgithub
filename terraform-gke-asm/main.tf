module "cluster" {
  source       = "git::https://github.com/lionelsakoue/gke-module.git//modules/cluster?ref=master"
  project_id   = var.project_id
  region       = var.region
  zone         = var.zone
  cluster_name = var.cluster_name
}

output "cluster_name" {
  value = module.cluster.cluster_name
}
