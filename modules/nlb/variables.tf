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

variable "alb_arn" {
  type = string
}
variable "alb_dns_name" {
  type = string
}