resource "aws_s3_bucket" "nlb-prod-bucket" {
  bucket = "nlb-prod-bucket"

  tags = {
    Name        = "NLB Bucket"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_acl" "NLBACLBucket" {
  bucket = aws_s3_bucket.nlb-prod-bucket.id
  acl    = "private"
}