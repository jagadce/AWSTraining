#Create VPC
data "aws_availability_zones" "available" {}
resource "aws_vpc" "Training" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Training"
  }
}


#Create Private subnet

resource "aws_subnet" "PrivateTrainingsubnet" {
  vpc_id     = aws_vpc.Training.id
  cidr_block = "10.0.1.0/24"
map_public_ip_on_launch = "false"
availability_zone = data.aws_availability_zones.available.id

  tags = {
    Name = "Trainig"
  }
}

resource "aws_subnet" "PrivateTrainingsubnet1" {
  vpc_id     = aws_vpc.Training.id
  cidr_block = "10.0.2.0/24"
map_public_ip_on_launch = "false"
availability_zone = data.aws_availability_zones.available[0]

  tags = {  
    Name = "Trainig"
  }
}

resource "aws_subnet" "PrivateTrainingsubnet2" {
  vpc_id     = aws_vpc.Training.id
  cidr_block = "10.0.3.0/24"
map_public_ip_on_launch = "false"
availability_zone = data.aws_availability_zones.available[0]

  tags = {
    Name = "Trainig"
  }
}

#Create Public subnet

resource "aws_subnet" "PublicTrainingsubnet" {
  vpc_id     = aws_vpc.Training.id
  cidr_block = "10.0.4.0/24"
map_public_ip_on_launch = "true"
availability_zone = data.aws_availability_zones.available[0]

  tags = {
    Name = "Trainig"
  }
}

resource "aws_subnet" "PublicTrainingsubnet1" {
  vpc_id     = aws_vpc.Training.id
  cidr_block = "10.0.5.0/24"
map_public_ip_on_launch = "true"
availability_zone = data.aws_availability_zones.available[0]

  tags = {
    Name = "Trainig"
  }
}

resource "aws_subnet" "PublicTrainingsubnet2" {
  vpc_id     = aws_vpc.Training.id
  cidr_block = "10.0.6.0/24"
map_public_ip_on_launch = "true"
availability_zone = data.aws_availability_zones.available[0]

  tags = {
    Name = "Trainig"
  }
}

#Create Gateway Internet

resource "aws_internet_gateway" "Gateway" {
  vpc_id = aws_vpc.Training.id

  tags = {
    Name = "Gateway"
  }
}

#Create Routing Table

resource "aws_route_table" "RoutingTable" {
  vpc_id = aws_vpc.Training.id

  route {
    cidr_block = "0.0.0.0/24"
    gateway_id = aws_internet_gateway.Gateway.id
  }

   tags = {
    Name = "RoutingTable"
  }
}

#Routing Table association

resource "aws_route_table_association" "Public-a" {
  subnet_id      = aws_subnet.PublicTrainingsubnet.id
  route_table_id = aws_route_table.RoutingTable.id
}

resource "aws_route_table_association" "Public-b" {
  subnet_id      = aws_subnet.PublicTrainingsubnet1.id
  route_table_id = aws_route_table.RoutingTable.id
}

resource "aws_route_table_association" "Public-c" {
  subnet_id      = aws_subnet.PublicTrainingsubnet2.id
  route_table_id = aws_route_table.RoutingTable.id
}