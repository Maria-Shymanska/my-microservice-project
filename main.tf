terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# -----------------------
# S3 backend & DynamoDB
# -----------------------
module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "maria-lesson5-terraform-state"
  table_name  = "terraform-locks"
}

# -----------------------
# VPC module
# -----------------------
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_name           = "lesson-8-9-vpc"
}

# -----------------------
# ECR module
# -----------------------
module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "lesson-5-ecr"
  scan_on_push = true
}

# -----------------------
# Jenkins module
# -----------------------
module "jenkins" {
  source            = "./modules/jenkins"
  kubeconfig_path   = "~/.kube/config"
  namespace         = "jenkins"
  chart_version     = "5.0.16"
  admin_user        = "admin"
  admin_password    = "admin123"
  cluster_name      = module.vpc.vpc_name
  oidc_provider_arn = "arn:aws:iam::123456789012:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/612131776505"
  oidc_provider_url = "https://oidc.eks.us-east-1.amazonaws.com/id/612131776505"
}

# -----------------------
# Argo CD module
# -----------------------
module "argo_cd" {
  source                     = "./modules/argo_cd"
  kubeconfig_path            = "~/.kube/config"
  namespace                  = "argocd"
  repo_name                  = "example-repo"
  repo_url                   = "https://github.com/YOUR_USERNAME/example-repo.git"
  repo_username              = "YOUR_USERNAME"
  repo_password              = "YOUR_TOKEN"
  app_name                   = "example-app"
  app_path                   = "django-chart"
  app_target_revision        = "main"
  app_destination_namespace  = "default"
}

module "rds" {
  source = "./modules/rds"

  name                       = "myapp-db"
  use_aurora                 = false
  aurora_instance_count     = 2

  # --- RDS-only ---
  engine                     = "postgres"
  engine_version             = "17.2"
  parameter_group_family_rds = "postgres17"

  # Common
  instance_class             = "db.t3.medium"
  allocated_storage          = 20
  db_name                    = "myapp"
  username                   = "postgres"
  password                   = "admin123AWS23"
  subnet_private_ids         = module.vpc.private_subnets
  subnet_public_ids          = module.vpc.public_subnets
  publicly_accessible        = true
  vpc_id                     = module.vpc.vpc_id
  multi_az                   = true
  backup_retention_period    = 7
  parameters = {
    max_connections              = "200"
    log_min_duration_statement   = "500"
  }

  tags = {
    Environment = "dev"
    Project     = "myapp"
  }
} 



