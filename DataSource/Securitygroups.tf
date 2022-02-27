data "aws_ip_ranges"  "us-west-iprange" {
    regions = ["us-west-1","us-west-2"]
    services = ["ec2"]
}

resource "aws_security_group" "Sec_GRP"{
      name = "1"
  ingress {
      from_port = "80"
      to_port = "80"
      protocol = "tcp"
      ipv6_cidr_blocks = data.aws_ip_ranges.us-west-iprange.ipv6_cidr_blocks
  }
}
