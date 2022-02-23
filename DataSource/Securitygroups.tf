data "aws_ip_ranges"  "us-west-iprange" {
    regions = ["us-west-1","us-west-2"]
    services = ["ec2"]
}

resource "aws_security_group" "sec_group" {
  
    name = "dafult1"
  ingress {
      from_port = "80"
      to_port = "80"
      protocol = "tcp"
      cidr_blocks = data.aws_ip_ranges.us-west-iprange.cidr_blocks
  }
}
