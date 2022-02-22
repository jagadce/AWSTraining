data "aws_availability_zones" "available" {} 
data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xemial-16.04-amd64-server-*"]
    }
    filter{
        name = "vitualization-type"
        values = ["hvm"] 
    }
  
}
resource "aws_instance" "Test" {
    count = 3
ami = data.aws_ami.ubuntu.id
instance_type = "t2.micro"
tags = {Name ="Test-${count.index}"}
availability_zone = data.aws_availability_zones.available.names[0]
}