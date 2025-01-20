variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
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

variable "engine_version" {
  type        = string
  default     = "15.10"
  description = "The version of the database engine"
}

variable "instance_class" {
  type        = string
  default     = "db.t3.medium"
  description = "The instance class for the RDS instance"
}

variable "allocated_storage" {
  type        = number
  default     = 20
  description = "The allocated storage size in GB"
}

variable "multi_az" {
  type        = bool
  default     = false
  description = "Whether the database instance is multi-AZ"
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