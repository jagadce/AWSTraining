resource "aws_s3_bucket" "jagadce" {
  bucket = "jagadce"

  tags = {
    Name        = "jagadce"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_acl" "ACLBucket" {
  bucket = aws_s3_bucket.jagadce.id
  acl    = "private"
}