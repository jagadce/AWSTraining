provider "aws" {
    access_key = "AKIAZY542AUL7IQF7UX6"
    secret_key =  "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"
    region = "us-east-2"
}

resource "aws_instance" "Myfirstinstance" {
    ami = "ami-05803413c51f242b7"
instance_type = "t2.micro"
}