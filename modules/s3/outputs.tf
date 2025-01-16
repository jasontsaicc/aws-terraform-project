output "s3_bucket_name" {
  value = aws_s3_bucket.tableau.bucket
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.tableau.arn
}

output "s3_bucket_url" {
  value = "https://${aws_s3_bucket.tableau.bucket}.s3.amazonaws.com"
}