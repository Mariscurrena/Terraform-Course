resource "aws_vpc" "vpc_virgin" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "VPC_VIRGIN" # UI VPC Name
    name = "test"
    env = "dev"
  }
}

resource "aws_vpc" "vpc_ohio" {
  cidr_block = "10.20.0.0/16"
  tags = {
    Name = "VPC_OHIO" # UI VPC Name
    name = "test"
    env = "dev"
  }
  provider = aws.ohio # Useful for multiple regions if doesn't want to have multiple terraform instance
}