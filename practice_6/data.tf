# This do not create a resource, just read a resource, in this case a rsa key
data "aws_key_pair" "key" {
    key_name = "myKey"
}
# Useful for IAM roles or IAM policies that exist in AWS, so there's no need to recreate those, just to use them.