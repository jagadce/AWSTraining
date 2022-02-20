resource "aws_instance" "Test" {
    count = 3
ami = "ami-05803413c51f242b7"
instance_type = "t2.micro"
tags = {Name ="Test-${count.index}"}
security_groups = "${var.security_groups}"
}
