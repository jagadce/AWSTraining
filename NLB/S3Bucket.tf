resource "aws_s3_bucket" "nlbprodbucket" {
  bucket = "nlbprodbucket"

  tags = {
    Name        = "NLB Bucket"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_acl" "nlbprodbucketacl" {
  bucket = aws_s3_bucket.nlbprodbucket.id
  acl    = "private"
}