terraform {
    backend "s3" {
        bucket = "mybackup-jag"
        key = "Terraform/AWSTraining"
        region = "us-west-1"
    }
}