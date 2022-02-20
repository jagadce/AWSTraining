variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
default = "us-east-2"  
}
variable "security_groups" {
    type = "list"
    default = ["sg-1234","sg-56678","sg-8798","sg-89879"]
}