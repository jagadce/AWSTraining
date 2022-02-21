resource "aws_instance" "Test" {
    count = 3
ami = lookup (var.ami,var.AWS_REGION)
instance_type = "t2.micro"
tags = {Name ="Test-${count.index}"}
security_groups = "${var.security_groups}"
}
