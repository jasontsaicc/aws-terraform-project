resource "aws_secretsmanager_secret" "rds_secret" {
  name        = "${var.project_name}-rds-credentials-new-v1"
  description = "RDS credentials for ${var.project_name}"

  tags = {
    Name = "${var.project_name}-rds-secret"
  }
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode(var.rds_credentials)
  depends_on = [aws_secretsmanager_secret.rds_secret]

}
