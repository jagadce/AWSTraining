resource "aws_instance" "Myfirstinstance" {
    count = "3"
    ami = "ami-05803413c51f242b7"
instance_type = "t2.micro"
tags = {
    Name = "Test-${count.index}"
}
}