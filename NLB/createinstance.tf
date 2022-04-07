resource "aws_key_pair" "Training_Key" {
  key_name   = "Training_Key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
 }


resource "aws_instance" "Name" {
instance_type = "t2.micro"
ami = "ami-0454207e5367abf01"
key_name = aws_key_pair.Training_Key.key_name
vpc_security_group_ids = [aws_security_group.allow_ssh.id]
subnet_id = aws_subnet.PublicTrainingsubnet1.id
user_data = file("Apacheinstall.sh")
tags = {
    Name ="test1"
    }
#availability_zone = data.aws_availability_zones.available.names[0]
}
output "public_ip" {
    value = aws_instance.Name.public_ip  
}
