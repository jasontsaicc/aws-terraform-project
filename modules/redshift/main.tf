resource "aws_redshift_subnet_group" "this" {
  name       = "${var.project_name}-redshift-sng"
  subnet_ids = var.subnet_id

  tags = {
    Name = "${var.project_name}-redshift-sng"
  }
}

resource "aws_security_group" "redshift_sg" {
  name_prefix = "${var.project_name}-redshift-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # 替換為你的網段
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-redshift-sg"
  }
}


resource "aws_redshift_cluster" "this" {
  cluster_identifier = "${var.project_name}-redshift"
  database_name      = "dev"
  master_username    = "admin"
  master_password    = "Admin1234"
  node_type          = "dc2.large"
  cluster_type       = "single-node"
  port =               5439

  cluster_subnet_group_name             = aws_redshift_subnet_group.this.name
  vpc_security_group_ids                = [aws_security_group.redshift_sg.id]
  publicly_accessible                   = false
  automated_snapshot_retention_period   = 1
  number_of_nodes                       = 1

  tags = {
    Name = "${var.project_name}-redshift"
  }
}
