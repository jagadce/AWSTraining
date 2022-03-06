resource "aws_s3_bucket" "bucket1" {
  bucket = "bucket1"

  tags = {
    Name        = "bucket1"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_acl" "ACLBucket" {
  bucket = aws_s3_bucket.bucket1.id
  acl    = "private"
}