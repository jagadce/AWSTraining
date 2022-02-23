data "aws_availability_zones" "available" {} 
#data "aws_ami" "RHEL" {
    most_recent = true
    owners = ["309956199498"]
    filter {
        name = "name"
        values = ["RHEL*"]
    }
   
}
resource "aws_instance" "Name" {
    count = 3
instance_type = "t2.micro"
ami = ami-0454207e5367abf01
tags = {Name ="test"}
availability_zone = data.aws_availability_zones.available.names[0]
}
