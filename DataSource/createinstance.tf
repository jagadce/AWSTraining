data "aws_availability_zones" "available" {} 
data "aws_ami" "RHEL" {
    most_recent = true
    owners = ["309956199498"]
    filter {
        name = "name"
        values = ["RHEL*"]
    }
   
}
resource "aws_instance" "Test" {
ami = data.aws_ami.RHEL.image_id
instance_type = "t2.micro"
tags = {
    name ="Test"
availability_zone = data.aws_availability_zones.available.names[0]
}
}