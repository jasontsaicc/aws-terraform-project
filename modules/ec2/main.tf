resource "aws_security_group" "tableau_ec2_sg" {
  name        = "${var.project_name}-sg"
  description = "Allow RDP, HTTP, and HTTPS access"
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
    Name = "${var.project_name}-security-group"
    Environment = "dev"
  }
}
resource "aws_eip" "table_ip" {
  instance = aws_instance.this.id
  domain   = "vpc"
  tags = {
    name = "${var.project_name}-tableau-ec2-ip"
    Environment = "dev"
  }
}


resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids
  vpc_security_group_ids        = [aws_security_group.tableau_ec2_sg.id]
  key_name      = var.ssh_key_name      
  # depends_on = [aws_security_group.tableau_ec2_sg]

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = {
    Name = "${var.project_name}-ec2"
    Environment = "dev"
  }
}