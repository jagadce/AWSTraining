data "aws_availability_zones" "R" {} 
data "aws_ami" "RHEL" {
    most_recent = true
    owners = ["309956199498"]
    filter {
        name = "R"
        values = ["RHEL*"]
    }
   
}
resource "aws_instance" "R" {
    count = 3
ami = data.aws_ami.RHEL.image_id
instance_type = "t2.micro"
tags = {Name ="R-${count.index}"}
availability_zone = data.aws_availability_zones.available.names[2]
}