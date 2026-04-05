# 🔥 Read GitHub token from Secret Manager
data "google_secret_manager_secret_version" "github_token" {
  secret  = "github-token"
  version = "latest"
}

# 🔥 Kubernetes secret for Config Sync
resource "kubernetes_secret_v1" "git_creds" {
  metadata {
    name      = "git-creds"
    namespace = "config-management-system"
  }

  data = {
    username = "lionelsakoue"
    token    = data.google_secret_manager_secret_version.github_token.secret_data
  }

  type = "Opaque"
}

# 🔥 RootSync resource
resource "kubernetes_manifest" "rootsync" {
  manifest = {
    apiVersion = "configsync.gke.io/v1beta1"
    kind       = "RootSync"
    metadata = {
      name      = "root-sync"
      namespace = "config-management-system"
    }
    spec = {
      sourceType   = "git"
      sourceFormat = "unstructured"
      git = {
        repo     = "https://github.com/lionelsakoue/shinner-deployment.git"
        branch   = "dev"
        revision = "HEAD"
        dir      = "overlays/shinner-dev"
        auth     = "token"
        secretRef = {
          name = "git-creds"
        }
      }
    }
  }
}
