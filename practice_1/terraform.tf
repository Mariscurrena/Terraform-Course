resource "local_file" "products" {
  content  = "Product List for the next mounth"
  filename = "products.txt"
}

#[=======================G-U-I-D-E=============================]#
# TERRAFORM is a declarative language, we say what to do but not how to do it
# terraform init -- Just the first time to initialize the terraform instance
# terraform plan -- Creates a deployment plan, but doesn't apply it. Shows the changes
# terraform apply -- Creates a deployment plan and apply it. Shows the changes
# terraform destroy -- Destroy the elements created in a deployment
# terraform fmt [Optional the tf file name, default all tf files in the directory]-- Gives the right identation of a terraform code
# terraform validate [Optional the tf file name, default all tf files in the directory]-- Valdidates that the syntaxis is correct. Its faster than "terraform plan", due to doesn't need connect with each provider
###### --- "terraform validate" fails if terraform wasn't initializedter

#[====================P-R-O-V-I-D-E-R==========================]#
# Local Provider - Interacts with the local instance
# https://registry.terraform.io/providers/hashicorp/local/latest