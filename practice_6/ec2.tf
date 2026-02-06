resource "aws_instance" "public_instance" {
    ami           = "ami-0532be01f26a3de55"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public_subnet.id
    tags = {
        "Name" = "EC2_Public_Instance"
    }
}