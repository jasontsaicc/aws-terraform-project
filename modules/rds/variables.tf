variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = list(string)
}

variable "secret_id" {
  type = string
  description = "The ID of the Secrets Manager secret for RDS credentials"
}

variable "secret_arn" {
  type        = string
  description = "The ARN of the Secrets Manager secret for RDS credentials"
}