resource "aws_instance" "public_instance" {
    ami           = "ami-0532be01f26a3de55"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public_subnet.id
    tags = {
        "Name" = "EC2_Public_Instance"
    }
}

# Here on the line 'aws_subnet.public_subnet.id' there's an implicit dependency, where it is needed first create the 'public_subnet' and then create this 'EC2_Public_Instance'
# However, not all times an implicit dependency is enough, there's situations where an explicit one is required
# e.g. When is needed to create a domain server and a domain member, before the member is created, it is explicitly required to have a domain controller
# In terraform this is explicitly declared using 'depends_on'
# e.g.
# # # # # depends_on {
# # # # #     aws_subnet=public_subnet
# # # # # }