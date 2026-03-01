variable "kubeconfig_path" {
  description = "Path to kubeconfig for EKS"
  type        = string
}

variable "chart_version" {
  description = "Helm chart version"
  type        = string
  default     = "4.5.0"
}

variable "admin_user" {
  description = "Jenkins admin username"
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Jenkins admin password"
  type        = string
  default     = "admin123"
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "jenkins"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the IAM OIDC provider"
  type        = string
}

variable "oidc_provider_url" {
  description = "URL of the IAM OIDC provider"
  type        = string
}


