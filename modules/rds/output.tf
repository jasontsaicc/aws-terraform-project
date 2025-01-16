output "rds_endpoint" {
  value = aws_db_instance.tableau.endpoint
}

output "secretsmanager_arn" {
  value = var.secret_arn
}

output "rds_name" {
  value = aws_db_instance.tableau.id
}

output "rds_arn" {
  value = aws_db_instance.tableau.arn
}

output "rds_port" {
  value = aws_db_instance.tableau.port
}