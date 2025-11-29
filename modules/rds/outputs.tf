
# -----------------------
output "rds_instance_id" {
  value       = var.use_aurora ? null : aws_db_instance.standard[0].id
  description = "Standard RDS instance ID"
}

output "rds_parameter_group_name" {
  value       = var.use_aurora ? null : aws_db_parameter_group.standard[0].name
  description = "Standard RDS parameter group name"
}

output "aurora_cluster_id" {
  value       = var.use_aurora ? aws_rds_cluster.aurora[0].id : null
  description = "Aurora cluster ID"
}

output "aurora_replicas_ids" {
  value       = var.use_aurora ? aws_rds_cluster_instance.aurora_replicas[*].id : null
  description = "Aurora replica IDs"
}