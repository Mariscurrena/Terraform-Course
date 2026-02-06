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

# Ensures all the executions land a proper availability zone
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_subnet" "public_subnet"{
  vpc_id = aws_vpc.vpc_virgin.id
  cidr_block = var.subnets[0]
  map_public_ip_on_launch = true # This creates the public subnet - Public redirection for resources
  # tags = var.tags
  tags = {
    "Name" = "public_subnet"
  }
  availability_zone = data.aws_availability_zones.available.names[0] # First instance of the availability zones
}

resource "aws_subnet" "private_subnet"{
  vpc_id = aws_vpc.vpc_virgin.id
  cidr_block = var.subnets[1]
  # tags = var.tags
  tags = {
    "Name" = "private_subnet"
  }
  depends_on = [ 
    aws_subnet.public_subnet 
  ]
}

# Targeting - Indicates what to deploy instead of deploy everything at once
#### --- NOTE: 'terraform apply --auto-approve=true' - Deploy without ask confirmation, not consider as a good practice, can also be used in destroy
### Targeting is useful for specific issues when an specific issue failed but not the whole infra
### e.g. Fix something in the public subnet, but not in the private cause its not ready yet
### e.g. terraform apply --targer aws_subnet.public_subnet