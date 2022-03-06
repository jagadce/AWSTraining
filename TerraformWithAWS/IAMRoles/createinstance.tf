resource "aws_key_pair" "Training_Key" {
  key_name   = "Training_Key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
 }


resource "aws_instance" "Test" {
instance_type = "t2.micro"
ami = "ami-0454207e5367abf01"
key_name = aws_key_pair.Training_Key.key_name
tags = {
    Name ="Test"
    }
#availability_zone = data.aws_availability_zones.available.names[0]
aws_iam_instance_profile = aws_iam_instance_profile.S3profile.name
}

output "public_ip" {
    value = aws_instance.Test.public_ip  
}




