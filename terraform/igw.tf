resource "aws_internet_gateway" "whoogleigw" {
  vpc_id = aws_vpc.whoogle_vpc.id
}
