resource "aws_key_pair" "Training_Key" {
  key_name   = "Training_Key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
 }


resource "aws_instance" "Name" {
    count = 3
instance_type = "t2.micro"
ami = "ami-0454207e5367abf01"
key_name = aws_key_pair.Training_Key.key_name

tags = {
    Name ="MyInstance ${count.index}"
    }
#availability_zone = data.aws_availability_zones.available.names[0]
}
#output "public_ip" {
 #   value = aws_instance.Name.public_ip  
#}
