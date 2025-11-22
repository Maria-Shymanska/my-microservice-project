terraform {
  backend "s3" {
    bucket         = "maria-lesson5-terraform-state"
    key            = "lesson-7/terraform.tfstate"
     region         = "us-east-1"
    dynamodb_table = "terraform-locks"
   encrypt        = true
   }
 }


