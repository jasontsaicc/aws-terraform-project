

variable "vpc_id" {
  type = string
}

variable "project_name" {
    type = string
}

variable "ami_id" {
  type = string
  default = "ami-07469e8b9deb9b996" 
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "subnet_id" {
  type = list(string)
}

variable "ssh_key_name" {
  default = "tableau_ec2_bastion"
}