data "aws_ip_ranges"  "us-west-ipranges" {
    region = ["us-west-1","us-west-2"]
    service = ["ec2"]
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
tags  {
    createdate = data.aws_ip_ranges.us-west-ipranges.create_date
    synctoken = data.aws_ip_ranges.us-west-ipranges.sync_token
}