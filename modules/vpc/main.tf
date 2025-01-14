# 建立 VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# 建立 subnet
resource "aws_subnet" "private" {
  count                   = length(var.subnet_cidr)  # 根據子網數量動態創建
  vpc_id                  = aws_vpc.this.id
  cidr_block             = var.subnet_cidr[count.index]
  availability_zone = local.availability_zones[count.index % length(local.availability_zones)]
  map_public_ip_on_launch = true  # 必須 true，才能綁 EIP / NLB
  tags = {
    Name = "${var.project_name}-private-subnet-${count.index + 1}"
  }
}


locals {
  availability_zones = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

