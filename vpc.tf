resource "aws_vpc" "my-vpc" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.my-vpc.id}"
  cidr_block        = "192.168.1.0/24"

  tags = {
    Name = "public"
  }
}

resource "aws_subnet" "pravite" {
  vpc_id            = "${aws_vpc.my-vpc.id}"
  cidr_block        = "192.168.6.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name = "pravite"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.my-vpc.id}"

  tags {
    Name = "VPC IGW"
  }
}

resource "aws_route_table" "public-RT" {
  vpc_id = "${aws_vpc.my-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public-RT.id}"
}
resource "aws_security_group" "my_sg" {
  name= "test-sg"
  description= "to allow all ports"
  ingress {
    from_port=0
    to_port=0
    protocol= "-1"
    cidr_blocks= ["0.0.0.0/0"]   
  }
  egress {
    from_port=0
    to_port=0
    protocol= "-1"
    cidr_blocks= ["0.0.0.0/0"]
  }
  vpc_id = "${aws_vpc.my-vpc.id}"
  
  tags ={
    Name = "DB-SG"
  }
}

