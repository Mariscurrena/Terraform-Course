# DRY -- Don't Repeat Yourself -- Best Practices using variables
resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  # tags = var.tags -- Tags from provider
  tags = {
    "Name" = "VPC_virginia-${local.sufix}"
  }
}

# Ensures all the executions land a proper availability zone
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true # This creates the public subnet - Public redirection for resources
  # tags = var.tags
  tags = {
    "Name" = "public_subnet-${local.sufix}"
  }
  availability_zone = data.aws_availability_zones.available.names[0] # First instance of the availability zones
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
  # tags = var.tags
  tags = {
    "Name" = "private_subnet-${local.sufix}"
  }
  depends_on = [
    aws_subnet.public_subnet
  ]
}

# Only can be an internet gateway per VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "IGW_virginia_VPC-${local.sufix}"
  }
}

# Route Table - It is not recommended use the default one
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0" # Supports go to internet from every route
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public_CRT-${local.sufix}"
  }
}

# Route Table Association - How the subnet will arrive to the destination
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

# Security Group - Similar to a firewall stateful / Network Interface
# From where and to where can be communicated
# What ongoing and outcoming traffic is allowed.
resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance Security Group"
  description = "Allow SSH inboud traffic and ALL egress traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

  # ingress {
  #   description = "SSH over internet"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }

  # Dynamic Block substitute the separate ingress rules
  dynamic "ingress" {
    for_each = var.ingress_port_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.sg_ingress_cidr]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Public_Instance_Security_Group-${local.sufix}"
  }
}
