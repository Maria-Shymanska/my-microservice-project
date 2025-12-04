terraform {
  backend "s3" {
    bucket         = "maria-finalproject-terraform-state"
    key            = "final-project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "maria-finalproject-terraform-lock"
    use_lockfile = true
  }
}



