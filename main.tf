resource "aws_vpc" "dell_vpc" {
  cidr_block = var.dell_vpc_cidr
  tags = {
    Name = "dev-vpc"
    instance_tenancy = "default"
  }
}

resource "aws_subnet" "publicsubnet"{
  vpc_id = aws_vpc.dell_vpc.id
  cidr_block = var.public_subnets
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Pb_Name = "public-subnet"
  }
}

resource "aws_subnet" "privatesubnet"{
  vpc_id = aws_vpc.dell_vpc.id
  cidr_block = var.private_subnets
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Pv_Name = "private-subnet"
  }
}

resource "aws_internet_gateway" "Igw" {
  vpc_id = aws_vpc.dell_vpc.id
  tags = {
    Igw_Name = "test-igw"
  }
}
resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id      = aws_eip.nat_eip.id
  subnet_id          = aws_subnet.publicsubnet.id
 tags = {
  Name               = "my-natway"
   }

}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.dell_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw.id
  }
  tags = {
    Name = "dev-route-table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.dell_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "dev-route-table"
  }
}


resource "aws_route_table_association" "public_route_table_association" {
  subnet_id = aws_subnet.publicsubnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id = aws_subnet.privatesubnet.id
  route_table_id = aws_route_table.private_route_table.id
}