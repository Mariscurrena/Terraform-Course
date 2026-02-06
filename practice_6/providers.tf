terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=6.15.0, <6.31.0, !=6.15.0" # Constrain: Provider version. Setting limits to avoid the most recent (bugs)
    }
  }
  required_version = "~>1.14" # Constrain: Terraform recommended way. Allows minor up versions from the specified one
}

provider "aws" {
    region = "us-east-1"
    default_tags { #Apply to all resouces without use tags explicitly
      tags = var.tags
    }
}