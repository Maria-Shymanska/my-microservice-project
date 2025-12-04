# CIDR блок для VPC
variable "vpc_cidr" {
  description = "CIDR блок для VPC"
  type        = string
}

# Список CIDR для публічних підмереж
variable "public_subnets" {
  description = "Список CIDR блоків для публічних підмереж"
  type        = list(string)
}

# Список CIDR для приватних підмереж
variable "private_subnets" {
  description = "Список CIDR блоків для приватних підмереж"
  type        = list(string)
}

# Список availability zones
variable "availability_zones" {
  description = "Список availability zones для підмереж"
  type        = list(string)
}

# Назва проєкту/ресурсу, використовується для тегів
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}







