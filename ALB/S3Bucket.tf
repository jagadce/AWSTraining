resource "aws_s3_bucket" "alb-bucket" {
  bucket = "alb-bucket"

  tags = {
    Name        = "alb-bucket"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_acl" "acl-alb-bucket" {
  bucket = aws_s3_bucket.alb-bucket.id
  acl    = "private"
}