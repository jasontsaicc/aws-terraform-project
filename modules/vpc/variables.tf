variable "project_name" {
    type = string
}

variable "vpc_cidr" {
    type = string
}

variable "subnet_cidr" {
    type = list(string)
  
}