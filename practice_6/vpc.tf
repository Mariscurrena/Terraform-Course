# resource "aws_vpc" "vpc_virgin" {
#   cidr_block = "10.10.0.0/16"
#   tags = {
#     Name = "VPC_VIRGIN" # UI VPC Name
#     name = "test"
#     env = "dev"
#   }
# }

# resource "aws_vpc" "vpc_ohio" {
#   cidr_block = "10.20.0.0/16"
#   tags = {
#     Name = "VPC_OHIO" # UI VPC Name
#     name = "test"
#     env = "dev"
#   }
#   provider = aws.ohio # Useful for multiple regions if doesn't want to have multiple terraform instance
# }

# DRY -- Don't Repeat Yourself -- Best Practices using variables
resource "aws_vpc" "vpc_virgin" {
  cidr_block = var.virginia_cidr
  # tags = var.tags -- Tags from provider
  tags = {
    "Name" = "VPC_Virgin"
  }
}

resource "aws_subnet" "public_subnet"{
  vpc_id = aws_vpc.vpc_virgin.id
  cidr_block = var.subnets[0]
  map_public_ip_on_launch = true # This creates the public subnet - Public redirection for resources
  # tags = var.tags
  tags = {
    "Name" = "Public_Subnet"
  }
}

resource "aws_subnet" "private_subnet"{
  vpc_id = aws_vpc.vpc_virgin.id
  cidr_block = var.subnets[1]
  # tags = var.tags
  tags = {
    "Name" = "Private_Subnet"
  }
}