resource "aws_key_pair" "Training_Key" {
  key_name   = "Training_Key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
 }


resource "aws_instance" "Test" {
instance_type = "t2.micro"
ami = "ami-0454207e5367abf01"
key_name = aws_key_pair.Training_Key.key_name
tags = {
    Name ="test1"
    }
#availability_zone = data.aws_availability_zones.available.names[0]
}
output "public_ip" {
    value = aws_instance.Test.private_ip  
}

#EBSVolume Creation

resource "aws_ebs_volume" "ExternalVolume" {
  availability_zone = "us-west-1a"
  size              = 40
  type = "gp2"

  tags = {
    Name = "ExternalVolume"
  }
}

#Attach the EBS volume to Instance

resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.ExternalVolume.id
  instance_id = aws_instance.Test.id
}
