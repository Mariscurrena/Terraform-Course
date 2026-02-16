resource "aws_instance" "public_instance" {
  ami           = var.ec2_specs.ami # Is not a good practice having the ami, instance and user_Data harcoded.
  instance_type = var.ec2_specs.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    "Name" = "EC2_Public_Instance"
  }
  key_name               = data.aws_key_pair.key.key_name # Calls the data
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  # All within the EOF will be executed (END-OF-FILE, defines the script area)
  # 'User Data' scripts are executed by the root user, instead of the 'ec2-user' that provisioners use.
  # user_data = <<-EOF
  #   #!/bin/bash
  #   echo 'This is a message using User Data / root user' > ~/README.txt
  #   echo 'This is a message using User Data / ec2-user user' > /home/ec2-user/README.txt
  # EOF
  user_data = file("scripts/userdata.sh") # Best way to avoid disclose any sensitive information
  # The script will not be visible to ec2-user, because it was created with root

  # Terraform common behaviour is first destroy, then create
  # Lifecycle supports change these properties
  #   lifecycle {
  #     create_before_destroy = true # Invert the order
  #     # prevent_destroy = true # Do not destoy in any context, this is for critical resources
  #     # ignore_changes = [ ami, subnet_id ] # Ignore the changes about the arguments
  #     # replace_triggered_by = [ aws_subnet.private_subnet ] # If the resources in args suffer a change will trigger the replacement
  #   }

  ### PROVISIONER IS NOT USED IN REAL WORLD SCENARIOS
  # Executes code
  provisioner "local-exec" {
    command = "echo Our Public IP is: ${aws_instance.public_instance.public_ip} >> aws_data.txt"
  }
  provisioner "local-exec" {
    when    = destroy                                                                   # create is default, conditions to the provisioner
    command = "echo Instance: ${self.public_ip} has been destroyed! :( >> aws_data.txt" #'self' is needed to destroy to indicate the resource where we are coding
  }
  # # (useful) terraform destroy  --target=aws_instance.public_instance --auto-approve=True
  # provisioner "remote-exec" {
  #   inline = [ # Inline is used always for "remote-exec"
  #     "echo 'Hello World' > ~/greeting.txt"
  #    ]
  #    # Needed to establish the connection before running the command
  #    connection {
  #      type = "ssh"
  #      host = self.public_ip
  #      user = "ec2-user" #default user
  #      private_key = file("../../../../Downloads/myKey.pem")
  #    }
  # }

  # FOR AWS 'USER DATA' IS THE RIGHT CHOICE
  # 'USER DATA' is an instance's functionality, here its possible to add the script with all the desired steps and then it will just be run while the creation, only in creation.


}

# Here on the line 'aws_subnet.public_subnet.id' there's an implicit dependency, where it is needed first create the 'public_subnet' and then create this 'EC2_Public_Instance'
# However, not all times an implicit dependency is enough, there's situations where an explicit one is required
# e.g. When is needed to create a domain server and a domain member, before the member is created, it is explicitly required to have a domain controller
# In terraform this is explicitly declared using 'depends_on'
# e.g.
# # # # # depends_on [
# # # # #     aws_subnet=public_subnet
# # # # # ]


############################ IMPORT EXAMPLE ###################################
# Import a resource
# Every import could be different, for that reason it is important to read the official documentation
# Useful using terraform state show 'resource', if it is needed to clone using IaC an existing resource that was created on the web console
# This approach required manual hardening
# resource "aws_instance" "MyWebServer" {
#     ami                                  = "ami-0c1fe732b5494dc14"
#     instance_type                        = "t3.micro"
#     key_name                             = data.aws_key_pair.key.key_name
#     subnet_id                            = aws_subnet.public_subnet.id
#     tags                                 = {
#         "Name" = "MyServer"
#     }
#     tenancy                              = "default"
#     vpc_security_group_ids               = [
#         aws_security_group.sg_public_instance.id
#     ]
# }