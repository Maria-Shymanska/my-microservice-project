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

# Підключаємо модуль S3 та DynamoDB
module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "maria-lesson5-terraform-state"
  table_name  = "terraform-locks"
}


# -----------------------
# Підключення VPC-модуля
# -----------------------
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"

  # Публічні підмережі
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  # Приватні підмережі
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  # Зони доступності
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  # Назва VPC
  vpc_name           = "lesson-8-9-vpc"
}

# Підключаємо модуль ECR
module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "lesson-5-ecr"
  scan_on_push = true
}

module "jenkins" {
  source          = "./modules/jenkins"
  kubeconfig_path = "~/.kube/config"
  namespace       = "jenkins"
  chart_version   = "5.0.16"
  admin_user      = "admin"
  admin_password  = "admin123"
  cluster_name    = module.vpc.vpc_name          # або module.eks.eks_cluster_name, якщо EKS
  oidc_provider_arn = "arn:aws:iam::123456789012:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/612131776505" # заміни на свій
  oidc_provider_url = "https://oidc.eks.us-east-1.amazonaws.com/id/612131776505"                               # заміни на свій
}


module "argo_cd" {
  source              = "./modules/argo_cd"
  kubeconfig_path     = "~/.kube/config"
  namespace           = "argocd"
  repo_name           = "example-repo"
  repo_url            = "https://github.com/YOUR_USERNAME/example-repo.git"
  repo_username       = "YOUR_USERNAME"
  repo_password       = "YOUR_TOKEN"
  app_name            = "example-app"
  app_path            = "django-chart"
  app_target_revision = "main"
  app_destination_namespace = "default"
}



