resource "aws_db_subnet_group" "tableau" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
    Environment = "dev"
  }
}

data "aws_secretsmanager_secret_version" "rds_secret" {
  secret_id = var.secret_id
}

resource "aws_security_group" "tableau-rds_sg" {
  name        = "${var.project_name}-rds-sg"
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


resource "aws_db_instance" "tableau" {
  identifier             = "${var.project_name}-rds"
  engine                 = "postgres"
  port                   = "5432"
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  db_subnet_group_name   = aws_db_subnet_group.tableau.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.tableau-rds_sg.id]
  multi_az               =  var.multi_az
  username               = jsondecode(data.aws_secretsmanager_secret_version.rds_secret.secret_string)["username"]
  password               = jsondecode(data.aws_secretsmanager_secret_version.rds_secret.secret_string)["password"]
  tags = {
    Name = "${var.project_name}-rds"
    Environment = "dev"
  }
    depends_on = [data.aws_secretsmanager_secret_version.rds_secret]

}