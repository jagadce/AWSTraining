variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
default = "us-east-2"  
}
variable "security_groups" {
    type = list
    default = ["sg-123","sg-56678","sg-8798"]
}
variable "ami" {
    type = map
    default = {
        us-east-2 = "iugiugiugiu"
        us-west-2 = "lhkjhkj"
    }
  
}