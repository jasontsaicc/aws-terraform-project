output "redshift_endpoint" {
  value = aws_redshift_cluster.this.endpoint
}


output "redshift_arn" {
  value = aws_redshift_cluster.this.arn
}

output "redshift_cluster_id" {
  value = aws_redshift_cluster.this.id
}
