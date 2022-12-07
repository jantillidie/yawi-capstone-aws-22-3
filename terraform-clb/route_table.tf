resource "aws_default_route_table" "private_route_table" {
  default_route_table_id = aws_vpc.whoogle_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }


  tags = {
    Name = "Private route table"
  }
}

resource "aws_route_table" "whoogle_route" {
  vpc_id = aws_vpc.whoogle_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.whoogleigw.id
  }
  tags = {
    Name = "Public route table"
  }
}

resource "aws_route_table_association" "rt1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.whoogle_route.id
}

resource "aws_route_table_association" "rt2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.whoogle_route.id
}
