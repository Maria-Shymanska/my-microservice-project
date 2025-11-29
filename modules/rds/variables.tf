variable "name" {
  description = "Назва інстансу або кластера"
  type        = string
}

variable "use_aurora" {
  description = "Створювати Aurora cluster"
  type        = bool
  default     = false
}



variable "engine" {
  description = "Движок БД для RDS"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Версія движка RDS"
  type        = string
  default     = "17.2"
}

variable "engine_cluster" {
  description = "Движок кластера Aurora"
  type        = string
  default     = "aurora-postgresql"
}

variable "engine_version_cluster" {
  description = "Версія движка Aurora"
  type        = string
  default     = "15.3"
}

variable "parameter_group_family_rds" {
  description = "Parameter group для RDS"
  type        = string
  default     = "postgres17"
}

variable "parameter_group_family_aurora" {
  description = "Parameter group для Aurora"
  type        = string
  default     = "aurora-postgresql15"
}

variable "instance_class" {
  description = "Клас інстансу"
  type        = string
  default     = "db.t3.medium"
}

variable "allocated_storage" {
  description = "Обсяг пам'яті (ГБ)"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Ім'я бази"
  type        = string
}

variable "username" {
  description = "Логін для БД"
  type        = string
}

variable "password" {
  description = "Пароль для БД"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_private_ids" {
  description = "Список приватних сабнетів"
  type        = list(string)
}

variable "subnet_public_ids" {
  description = "Список публічних сабнетів"
  type        = list(string)
}

variable "publicly_accessible" {
  description = "Доступ з публічної мережі"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Використовувати Multi-AZ"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Термін зберігання бекапів (днів)"
  type        = number
  default     = 7
}

variable "parameters" {
  description = "Додаткові параметри Parameter Group"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Теги для ресурсів"
  type        = map(string)
  default     = {}
}


variable "aurora_instance_count" {
  description = "Кількість реплік для Aurora кластеру"
  type        = number
  default     = 2
}

variable "aurora_replica_count" {
  description = "Кількість реплік Aurora для кластера"
  type        = number
  default     = 2
}
