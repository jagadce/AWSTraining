resource "aws_s3_bucket" "NLB_PROD_Backup" {
  bucket = "NLB_PROD_Backup"

  tags = {
    Name        = "NLB Bucket"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_acl" "NLBACLBucket" {
  bucket = aws_s3_bucket.NLB_PROD_Backup.id
  acl    = "private"
}