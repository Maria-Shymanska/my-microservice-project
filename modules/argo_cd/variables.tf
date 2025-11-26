variable "kubeconfig_path" {
  description = "Path to kubeconfig for ArgoCD"
  type        = string
}

variable "namespace" {
  description = "Namespace for ArgoCD"
  type        = string
  default     = "argocd"
}

variable "repo_name" {
  description = "Name for the Git repo secret"
  type        = string
}

variable "repo_url" {
  description = "Git repository URL"
  type        = string
}

variable "repo_username" {
  description = "Git repository username"
  type        = string
}

variable "repo_password" {
  description = "Git repository password or token"
  type        = string
}

variable "app_name" {
  description = "ArgoCD Application name"
  type        = string
}

variable "app_path" {
  description = "Path in repo for Helm chart or manifests"
  type        = string
}

variable "app_target_revision" {
  description = "Git branch/tag to sync"
  type        = string
  default     = "main"
}

variable "app_destination_namespace" {
  description = "Namespace where app will be deployed"
  type        = string
  default     = "default"
}

