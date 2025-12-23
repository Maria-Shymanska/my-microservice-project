variable "cluster_name" {}
variable "cluster_version" {
  default = "1.34"
}
variable "subnet_ids" {
  type = list(string)
}
variable "tags" {
  type    = map(string)
  default = {}
}

variable "node_group_name" {
  default = "eks-node-group"
}




