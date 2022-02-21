resource "aws_instance" "Test" {
    count = 3
ami = lookup (var.AWS_REGION, var.ami)
instance_type = "t2.micro"
tags = {Name ="Test-${count.index}"}
security_groups = "${var.security_groups}"
}
