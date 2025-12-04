# ======================
# Provider
# ======================
provider "aws" {
  region = "us-east-1"  # всі ресурси будуть у Frankfurt
}



# ======================
# Модуль S3 backend (для інших ресурсів, якщо потрібен)
# ======================
module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "maria-finalproject-terraform-state"
  table_name  = "maria-finalproject-terraform-lock"
}

# ======================
# Модуль VPC
# ======================
module "vpc" {
  vpc_name = "final-project"
  source = "./modules/vpc"

  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# ======================
# Модуль ECR
# ======================
module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "final-project-ecr"
  scan_on_push = true
}


