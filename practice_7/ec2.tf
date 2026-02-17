# List -- Used in 'count'
# variable "instances" {
#   description = "Instances name"
#   type        = list(string)
#   default     = ["apache", "mysql", "jumpserver"]
# }

# resource "aws_instance" "public_instance" {
#   # 'count' is not the better approach to create multiple instances, because do not delete an specific instance, just redistribute them
#   # 'count' is concerned about the array space, not about the tag.
#   count                  = length(var.instances)
#   ami                    = var.ec2_specs.ami 
#   instance_type          = var.ec2_specs.instance_type
#   subnet_id              = aws_subnet.public_subnet.id
#   key_name               = data.aws_key_pair.key.key_name 
#   vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
#   user_data              = file("scripts/userdata.sh") 
#   tags = {
#     "name" = var.instances[count.index] # Count.index is the current index
#   }
# }


# set or map variables are for 'for_each'
variable "instances" {
  description = "Instances name"
  type        = set(string)
  default     = ["apache", "mysql", "jumpserver"]
}

resource "aws_instance" "public_instance" {
  # 'For_Each' can only be used with set and map variables (IMPORTANT)
  # set() cannot have duplicated values
  for_each = var.instances
  # for_each             = toset(var.instances) # 'toset' transform a list into a set(), useful when a list is needed in all other resources.
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")
  tags = {
    "name" = each.value # Tha way to consute set()'s elements
  }
}
# This approach support targeting an specific resource creating with a bucle foer delete it or modify it. 
# While 'count' generates a resources' array, a 'for_each' creates a resources' map

# Terraform Console - CMD: 'terraform console'
# Useful to test terraform functions without impact the infrastructure

resource "aws_instance" "monitoring_instance" {
  # count = var.enable_monitoring ? 1:0 # Conditional: If 'true' value is 1, else 'false' value is 0
  # CONDITIONAL: is also possible to use >, >=, !=, etc
  # CONDITIONAL: Multiple conditions (1==1) && !(2==1), (1==1) || !(2==1)
  count                  = var.enable_monitoring == 1 ? 1 : 0 # Conditional: If '1' true and deploy, else false and don't deploy
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")
  tags = {
    "name" = "Monitoring"
  }
}