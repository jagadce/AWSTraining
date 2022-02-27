terraform {
    backend "S3" {
        bucket = "mybackup-jag"
        key = "Terraform/AWSTraining"
        region = "us-west-2"
    }
}