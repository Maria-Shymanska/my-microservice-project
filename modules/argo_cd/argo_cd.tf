provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

# 1️⃣ Встановлення ArgoCD через Helm
resource "helm_release" "argo_cd" {
  name       = "argo-cd"
  namespace  = var.namespace
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.12.6"
  create_namespace = true
}

# 2️⃣ Додавання приватного Git репозиторію через Secret
resource "kubernetes_manifest" "git_repo" {
  manifest = {
    apiVersion = "v1"
    kind       = "Secret"
    metadata = {
      name      = var.repo_name
      namespace = var.namespace
      labels = {
        "argocd.argoproj.io/secret-type" = "repository"
      }
    }
    type = "Opaque"
    stringData = {
      url      = var.repo_url
      username = var.repo_username
      password = var.repo_password
      insecure = "true"
    }
  }

  depends_on = [helm_release.argo_cd]
}

# 3️⃣ Створення ArgoCD Application
resource "kubernetes_manifest" "application" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = var.app_name
      namespace = var.namespace
    }
    spec = {
      project = "default"
      source = {
        repoURL        = var.repo_url
        targetRevision = var.app_target_revision
        path           = var.app_path
        helm = {
          valueFiles = ["values.yaml"]
        }
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = var.app_destination_namespace
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        syncOptions = ["CreateNamespace=true"]
      }
    }
  }

  depends_on = [kubernetes_manifest.git_repo]
}



