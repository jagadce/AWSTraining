resource "aws_eip" "NATGateway" {
vpc = true
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.NATGateway.id
  subnet_id     = aws_subnet.PrivateTrainingsubnet.id
 depends_on = [aws_internet_gateway.Gateway]

}


#Outer Machine cannot access my machine
resource "aws_route_table" "Private" {
  vpc_id = aws_vpc.Training.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw.id
  }

   tags = {
    Name = "Private"
  }
}

resource "aws_route_table_association" "Private-a" {
  subnet_id      = aws_subnet.PrivateTrainingsubnet.id
  route_table_id = aws_route_table.Private.id
}

resource "aws_route_table_association" "Private-b" {
  subnet_id      = aws_subnet.PrivateTrainingsubnet1.id
  route_table_id = aws_route_table.Private.id
}

resource "aws_route_table_association" "Private-c" {
  subnet_id      = aws_subnet.PrivateTrainingsubnet2.id
   route_table_id = aws_route_table.Private.id
}