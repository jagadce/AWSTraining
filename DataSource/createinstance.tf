data "aws_availability_zone" "available" {} 
data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]
    filter {
        name = "name"
        values = "ubuntu/images/hvm-ssd/ubuntu-xemial-16.04-amd64-server-*"
    }
    filter{
        name = "vitualization-type"
        values = ["hvm"] 
    }
  
}
resource "aws_instance" "Test" {
    count = 3
ami = lookup (var.ami,var.AWS_REGION)
instance_type = "t2.micro"
tags = {Name ="Test-${count.index}"}
availability_zone = data.aws_availability_zone.available.name[0]
}