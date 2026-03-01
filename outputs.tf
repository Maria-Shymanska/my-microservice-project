# -----------------------
output "rds_endpoint" {
  value       = module.rds.use_aurora ? module.rds.cluster_endpoint : module.rds.db_endpoint
  description = "Aurora cluster endpoint або RDS instance endpoint"
}

output "rds_instance_id" {
  value       = module.rds.use_aurora ? module.rds.cluster_id : module.rds.db_instance_id
  description = "Aurora cluster ID або RDS instance ID"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "IDs of public subnets"
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "IDs of private subnets"
}


