data "aws_ip_ranges"  "us-west-iprange" {
    regions = ["us-west-1","us-west-2"]
    services = ["ec2"]
}

resource "aws_security_group" "sg-custom-sec" {
    name = "sg-custom-sec"
  ingress {
      from_port = 80
      to_port = 80
      protocol = tcp/udp
      cidr_blocks = data.aws_ip_ranges.us-west-ipranges.cidr_blocks
  }
}
