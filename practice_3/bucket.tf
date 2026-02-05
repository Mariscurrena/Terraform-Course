resource "aws_s3_bucket" "providers" {
    count = 6
    bucket = "providers-${random_string.sufix[count.index].id}"
    tags = {
        Owner = "Steve"
        Environment = "Dev"
        Office = "Providers"
    }
}

resource "random_string" "sufix" {
    count = 6
    length  = 12
    special = false
    upper = false
    numeric = false # Number is deprecated
}

#[====================P-R-O-V-I-D-E-R==========================]#
# aws login
# AWS Provider - S3 Storage
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

#EXAM Note: Terraform can create up to 10 resources in parallel, it can be customized but 10 is default