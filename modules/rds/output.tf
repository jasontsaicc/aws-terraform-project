output "rds_endpoint" {
  value = aws_db_instance.tableau.endpoint
}

output "secretsmanager_arn" {
  value = var.secret_arn
}
