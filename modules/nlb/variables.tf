variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
 type =  list(string)
}

variable "enable_eip" {
  type    = bool
  default = true
}