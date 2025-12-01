output "release_name" {
  description = "Helm release name for Jenkins"
  value       = helm_release.jenkins.name
}

output "namespace" {
  description = "Kubernetes namespace for Jenkins"
  value       = helm_release.jenkins.namespace
}

output "admin_user" {
  description = "Jenkins admin username"
  value       = var.admin_user
}

output "admin_password" {
  description = "Jenkins admin password"
  value       = var.admin_password
}
