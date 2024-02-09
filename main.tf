provider "aws" {
 region    = "ap-south-1"
 access_key = "*****************"
 secret_key = "**********************"
}
resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"
  instance_tenancy = "default"

   tags = {
     Name = "main"
 }
}

#creating subnet

resource "aws_subnet" "main_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Main_subnet"
  }
}

#creating internet gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

#Route Table

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

#inbound rule to allow subnet to internet access
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
     }
     tags = {
    Name = "main_RT"
  }
}

#Routetable main_RT association with subnet Main_subnet

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "webSg" {
  name   = "web"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-sg"
  }
}

#Creating a simple t2.micro Ec2 instance 

resource "aws_instance" "testmachine" {
  ami                    = "ami-0449c34f967dbf18a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-id"]
  subnet_id              = "subnet id"  ###Add the subnet id of your created subnet
}
