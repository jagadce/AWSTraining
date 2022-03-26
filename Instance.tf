resource "aws_instance" "Name" {
instance_type = "t2.micro"
ami = "ami-0454207e5367abf01"
access_key = "AKIAZY542AUL636LXBPF"
region = "us-west-1"  
tags = {
    Name ="test1"
    }
}
} 