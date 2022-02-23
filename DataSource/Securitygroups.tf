data "aws_ip_ranges"  "us-west-iprange" {
    regions = ["us-west-1","us-west-2"]
    services = ["ec2"]
}

resource "aws_security_group" "name"{
      name = ""
  ingress {
            protocol = "tcp"
      cidr_blocks = data.aws_ip_ranges.us-west-iprange.cidr_blocks
  }
}
