variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
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

variable "alb_target_group_arn" {
  type        = string
  description = "Target group ARN of the ALB"
}