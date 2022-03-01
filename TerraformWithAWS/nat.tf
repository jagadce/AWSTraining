resource "aws_eip" "NATGateway" {
vpc = true
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.NATGateway
  subnet_id     = aws_subnet.PublicTrainingsubnet
 depends_on = [aws_internet_gateway.gw]
  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
 
}


#Outer Machine cannot access my machine
resource "aws_route_table" "Private" {
  vpc_id = aws_vpc.Training.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_internet_gateway.NATGateway
  }

   tags = {
    Name = "Private"
  }
}

resource "aws_route_table_association" "Private-a" {
  subnet_id      = aws_subnet.PrivateTrainingsubnet.id
  route_table_id = aws_route_table.Private
}

resource "aws_route_table_association" "Private-b" {
  subnet_id      = aws_subnet.PrivateTrainingsubnet1.id
  route_table_id = aws_route_table.Private
}

resource "aws_route_table_association" "Private-c" {
  subnet_id      = aws_subnet.PrivateTrainingsubnet2.id
   route_table_id = aws_route_table.Private
}