provider "aws" {
    region = "ap-south-1"
  
}
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    tags = {
        Name = "javahome"
    }
  
}
resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "JHC-IGW"
      Env = "production"
    }
  
}
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "public-subnet"
    }
  
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1b"
    tags = {
      Name = "private-subnet"
    }
  
}

resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.2.0/24"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    name = "public-rt"
  }
  
}

resource "aws_route_table_association" "abc" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.pub-rt.id
  
}

resource "aws_route_table" "pri-rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    name = "private-rt"
  }
  
}

resource "aws_route_table_association" "xyz" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.pri-rt.id
  
}
  
#create ec2 in public instance name dev
resource "aws_instance" "dev" {
  ami = "ami-0af9569868786b23a"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  subnet_id = aws_subnet.public.id
  tags = {
    name = "dev server"
  }
  
}

#create ec2 instance in private subnet name app-server
resource "aws_instance" "app-server" {
   ami = "ami-0af9569868786b23a"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1b"
  subnet_id = aws_subnet.private.id
  tags = {
    name = "app server"
  }
  
}


#create private subnet 2 and with attching create one ec2 name db-server

resource "aws_subnet" "private2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "private-subnet2"
    }
  
}


resource "aws_instance" "db-server" {
   ami = "ami-0af9569868786b23a"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  subnet_id = aws_subnet.private2.id
  tags = {
    name = "db server"
  }
  
}