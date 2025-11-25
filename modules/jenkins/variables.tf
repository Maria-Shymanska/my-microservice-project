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

