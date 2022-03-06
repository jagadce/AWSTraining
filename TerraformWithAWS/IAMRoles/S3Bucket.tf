resource "aws_s3_bucket" "jagbucket1" {
  bucket = "jagbucket1"

  tags = {
    Name        = "jagbucket1"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_acl" "ACLBucket" {
  bucket = aws_s3_bucket.jagbucket1.id
  acl    = "private"
}