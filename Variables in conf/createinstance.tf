resource "aws_instance" "Test" {
ami = "ami-05803413c51f242b"
instance_type = "t2.micro"
tags = {Name ="Test"}
}