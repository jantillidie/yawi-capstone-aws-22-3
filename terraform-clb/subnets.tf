# Public Subnet-1
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.whoogle_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
}

# Public Subnet-2
resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.whoogle_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"
}

# Private Subnet-1
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.whoogle_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2a"
}

# Private Subnet-2
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.whoogle_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-2b"
}
