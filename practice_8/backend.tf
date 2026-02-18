# terraform {
#   required_version = ">= 1.0.0"

#   backend "s3" {
#     region  = "us-east-1"
#     bucket  = "cerberus-unique-eg-2026-us-east-1-prod-terraform-state"
#     key     = "terraform.tfstate"
#     profile = ""
#     encrypt = "true"

#     dynamodb_table = "cerberus-unique-eg-2026-us-east-1-prod-terraform-state-lock"
#   }
# }
