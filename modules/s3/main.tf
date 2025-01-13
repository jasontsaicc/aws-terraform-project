resource "aws_s3_bucket" "tableau" {
  bucket = "${var.project_name}-bucket"
  tags = {
    Name = "${var.project_name}-bucket"
  }
}


resource "aws_s3_bucket_ownership_controls" "tableau" {
  bucket = aws_s3_bucket.tableau.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "tableau" {
  depends_on = [aws_s3_bucket_ownership_controls.tableau]

  bucket = "${var.project_name}-bucket"
  acl    = "private"
}