variable "project_name" {
  type = string
}

variable "public_subnet_ids" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "c5.4xlarge"
}

variable "volume_size" {
  type    = number
  default = 300
}

variable "volume_type" {
  type    = string
  default = "gp3"
}

variable "ami_id" {
  type = string
  default = "ami-0dcbb56b78eb8378d" # Windows Server 2022 的 AMI ID
}

variable "ssh_key_name" {
  default = "tableau_ec2_bastion"
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