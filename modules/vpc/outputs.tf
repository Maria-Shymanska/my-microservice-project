# -----------------------
# Standard RDS Outputs
# -----------------------
output "rds_instance_id" {
  value       = var.use_aurora ? null : aws_db_instance.standard[0].id
  description = "Standard RDS instance ID"
}

output "rds_endpoint" {
  value       = var.use_aurora ? null : aws_db_instance.standard[0].endpoint
  description = "Standard RDS endpoint"
}

output "rds_parameter_group_name" {
  value       = var.use_aurora ? null : aws_db_parameter_group.standard[0].name
  description = "Standard RDS parameter group name"
}

# -----------------------
# Aurora Outputs
# -----------------------
output "aurora_cluster_id" {
  value       = var.use_aurora ? aws_rds_cluster.aurora[0].id : null
  description = "Aurora cluster ID"
}

output "aurora_writer_endpoint" {
  value       = var.use_aurora ? aws_rds_cluster_instance.aurora_writer[0].endpoint : null
  description = "Aurora writer endpoint"
}

output "aurora_readers_endpoints" {
  value       = var.use_aurora ? [for r in aws_rds_cluster_instance.aurora_readers : r.endpoint] : null
  description = "Aurora reader endpoints"
}

# -----------------------
# Unified DB Endpoint (optional)
# -----------------------
output "db_main_endpoint" {
  value       = var.use_aurora ? aws_rds_cluster_instance.aurora_writer[0].endpoint : aws_db_instance.standard[0].endpoint
  description = "Main database endpoint, works for both RDS and Aurora"
}


