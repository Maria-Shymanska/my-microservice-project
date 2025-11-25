output "argo_cd_server" {
  value = helm_release.argocd.status
}
