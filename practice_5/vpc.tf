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
  tags = {
    Name = "VPC_VIRGIN" # UI VPC Name
    name = "test"
    env = "dev"
  }
}

resource "aws_vpc" "vpc_ohio" {
  cidr_block = var.ohio_cidr
  tags = {
    Name = "VPC_OHIO" 
    name = "test"
    env = "dev"
  }
  provider = aws.ohio
}

# There's multiple ways to work with variables

# 1. Explicitly set a value in the default attribute of the variable
# 2. If variable is empty, terraform ask in the terminal the values, it is not too much used
# 3. Variables can be defined as environment variables, 'export TF_VAR_[variable name, e.g. virginia_cidr]', must be defined with the prefix 'TF_VAR' 
# 4. Set in terraform plan - 'terraform plan -var ohio_cidr="10.10.0.0/16"'
###### unset TF_VAR_[variable name, e.g. virginia_cidr], delete the env var

# Best Practice: Have a specific var file.

