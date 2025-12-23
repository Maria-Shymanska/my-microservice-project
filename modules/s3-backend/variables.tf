variable "bucket_name" {
  description = "The name of the S3 bucket used for Terraform state"
  type        = string
}

variable "table_name" {
  description = "The name of the DynamoDB table for Terraform locks"
  type        = string
}

variable "environment" {
  description = "Environment name for tags"
  type        = string
  default     = "lesson-7"
}




