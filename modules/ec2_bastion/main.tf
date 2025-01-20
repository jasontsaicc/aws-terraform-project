resource "aws_security_group" "ec2_public_sg" {
  name        = "${var.project_name}-ec2-public-eks-bastion-sg"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "${var.project_name}-ec2-public-eks-bastion-sg"
    Environment = "dev"
  }
}
resource "aws_eip" "bastion_ip" {
  instance = aws_instance.ec2_eks_bastion.id
  domain   = "vpc"
  tags = {
    name = "${var.project_name}-ec2-eks-bastion-ip"
    Environment = "dev"
  }
}

resource "aws_instance" "ec2_eks_bastion" {
  ami           = var.ami_id
  instance_type = var.instance_type                  
  subnet_id     = var.public_subnet_ids [0]
  key_name      = var.ssh_key_name               # SSH Key，用於連接 EC2
  user_data = var.ec2_user_data


  # 指定 Security Group
  vpc_security_group_ids = [
    aws_security_group.ec2_public_sg.id
  ]
  
  # 自動分配公共 IP

  tags = {
    Name = "${var.project_name}-public-ec2_eks_bastion"
    Environment = "dev"
  }
}
