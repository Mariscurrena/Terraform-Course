resource "aws_instance" "public_instance" {
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    "Name" = "EC2_Public_Instance"
  }
  key_name               = data.aws_key_pair.key.key_name # Calls the data
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]

  # Terraform common behaviour is first destroy, then create
  # Lifecycle supports change these properties
  #   lifecycle {
  #     create_before_destroy = true # Invert the order
  #     # prevent_destroy = true # Do not destoy in any context, this is for critical resources
  #     # ignore_changes = [ ami, subnet_id ] # Ignore the changes about the arguments
  #     # replace_triggered_by = [ aws_subnet.private_subnet ] # If the resources in args suffer a change will trigger the replacement
  #   }
}

# Here on the line 'aws_subnet.public_subnet.id' there's an implicit dependency, where it is needed first create the 'public_subnet' and then create this 'EC2_Public_Instance'
# However, not all times an implicit dependency is enough, there's situations where an explicit one is required
# e.g. When is needed to create a domain server and a domain member, before the member is created, it is explicitly required to have a domain controller
# In terraform this is explicitly declared using 'depends_on'
# e.g.
# # # # # depends_on [
# # # # #     aws_subnet=public_subnet
# # # # # ]