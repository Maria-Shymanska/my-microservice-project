variable "ecr_name" {
  description = "Name of the ECR repository"
  default     = "lesson-7-django-app"
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  default     = true
}


