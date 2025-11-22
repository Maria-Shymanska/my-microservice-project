provider "aws" {
  region = "us-east-1"
}

# Підключаємо модуль S3 та DynamoDB
 module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "maria-lesson7-terraform-state"
  table_name  = "terraform-locks"
  environment = "lesson-7"
}

# Підключаємо модуль VPC
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_name           = "lesson-5-vpc"
}

module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "lesson-7-ecr"   
  scan_on_push = true
}



# Модуль EKS (Kubernetes Cluster)

module "eks" {
  source       = "./modules/eks"
  cluster_name = "lesson-7-eks"
  subnet_ids   = module.vpc.private_subnets
  tags = {
    Project = "Lesson7"
  }
}
