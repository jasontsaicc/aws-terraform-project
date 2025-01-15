resource "aws_db_subnet_group" "tableau" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.subnet_id

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

data "aws_secretsmanager_secret_version" "rds_secret" {
  secret_id = var.secret_id
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
  multi_az               =  var.multi_az
  username               = jsondecode(data.aws_secretsmanager_secret_version.rds_secret.secret_string)["username"]
  password               = jsondecode(data.aws_secretsmanager_secret_version.rds_secret.secret_string)["password"]
  tags = {
    Name = "${var.project_name}-rds"
  }
}