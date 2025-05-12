# Internet Gateway for public access
resource "aws_internet_gateway" "intotheinterwebs" {
  vpc_id = aws_vpc.DeployLab_VPC.id

  tags = {
    Name = "IGW"
  }
}

# Public Route Table with route to the Internet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.DeployLab_VPC.id
  tags = { 
    Name = "PublicRT" 
    }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.intotheinterwebs.id
  }
}

# Associate public subnets to the public route table
resource "aws_route_table_association" "PublicRT_assoc_public_a" {
  subnet_id      = aws_subnet.public["public-1"].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "PublicRT_assoc_public_b" {
  subnet_id      = aws_subnet.public["public-4"].id
  route_table_id = aws_route_table.public_route_table.id
}



# Elastic IP for the NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "NAT EIP"
  }
}

# NAT Gateway in a public subnet (update subnet ID if needed)
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public["public-4"].id
  tags = {
    Name = "NATGW"
  }
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.DeployLab_VPC.id
  tags = {
    Name = "PrivateRT"
  }
}

# Route in the private route table to NAT Gateway
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

# Route Table Associations for Private Subnets
resource "aws_route_table_association" "PrivateRT_assoc_private_a" {
  subnet_id      = aws_subnet.private["private-2"].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "PrivateRT_assoc_private_b" {
  subnet_id      = aws_subnet.private["private-3"].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "PrivateRT_assoc_private_c" {
  subnet_id      = aws_subnet.private["private-5"].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "PrivateRT_assoc_private_d" {
  subnet_id      = aws_subnet.private["private-6"].id
  route_table_id = aws_route_table.private_route_table.id
}

