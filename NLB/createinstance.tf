resource "aws_key_pair" "Training_Key" {
  key_name   = "Training_Key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
 }


resource "aws_instance" "test1" {
    count = 2
instance_type = "t2.micro"
ami = "ami-0454207e5367abf01"
key_name = aws_key_pair.Training_Key.key_name
vpc_security_group_ids = [aws_security_group.Secgrp_Instance.id]
subnet_id = aws_subnet.PublicTrainingsubnet1.id
user_data = file("Apacheinstall.sh")
tags = {
    Name ="MyInstance1${count.index}"
    }
}
 