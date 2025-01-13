output "secret_id" {
  value = aws_secretsmanager_secret.rds_secret.id
}

output "secret_arn" {
  value = aws_secretsmanager_secret.rds_secret.arn
}
