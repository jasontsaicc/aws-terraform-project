variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type =  list(string)
}

variable "database_name" {
  type = string
  default = "dev"
}

variable "node_type" {
  type = string
  default = "dc2.large"
}

variable "cluster_type" {
  type = string
  default = "single-node"
}

variable "port" {
  type = number
  default = 5439
}

variable "number_of_nodes" {
  type = number
  default = 1
}

variable "automated_snapshot_retention_period" {
  type = number
  default = 1
  
}