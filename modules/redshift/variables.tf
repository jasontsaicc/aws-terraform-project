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

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

}

variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

}