data "aws_availability_zones" "available" {} 
data "aws_ami" "Ubuntu" {
    most_recent = true
    owners = ["309956199498"]
    filter {
        name = "name"
        values = ["ubuntu*"]
    }
   
}
resource "aws_instance" "Name" {
    count = 3
instance_type = "t2.micro"
ami = data.aws_ami.Ubuntu.image_id
tags = {Name ="Test-${count.index}"}
availability_zone = data.aws_availability_zones.available.names[0]
}
