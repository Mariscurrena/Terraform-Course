output "ec2_public_ip"{
    description = "Instance Public IP"
    value = aws_instance.public_instance.public_ip
}