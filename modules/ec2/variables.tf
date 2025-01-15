variable "project_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "instance_type" {
  type    = string
}

variable "volume_size" {
  type    = number
  default = 30
}

variable "volume_type" {
  type    = string
  default = "gp3"
}

variable "ami_id" {
  type = string
  default = "ami-0dcbb56b78eb8378d" # Windows Server 2022 的 AMI ID
}