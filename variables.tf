variable "aws_region" {
    type = string
    default = "ap-southeast-1"
}

variable "project_name" {
    type = string
    default = "tableau-dev"
}

variable "vpc_cidr" {
    type = string
    default = "10.10.0.0/16"
}

variable "subnet_cidr" {
    type = list(string)
    default = [
        "10.10.1.0/24",
        "10.10.2.0/24"]  # subnet 2
}

variable "instance_type" {
    type = string
    default = "t3.medium"
}