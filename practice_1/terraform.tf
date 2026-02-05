resource "local_file" "products" {
    content = "Product List for the next mounth"
    filename = "products.txt"
}

#[=======================G-U-I-D-E=============================]#
# TERRAFORM is a declarative language, we say what to do but not how to do it
# terraform init -- Just the first time to initialize the terraform instance
# terraform plan -- Creates a deployment plan, but doesn't apply it. Shows the changes
# terraform apply -- Creates a deployment plan and apply it. Shows the changes
# terraform destroy -- Destroy the elements created in a deployment

#[====================P-R-O-V-I-D-E-R==========================]#
# Local Provider - Interacts with the local instance
# https://registry.terraform.io/providers/hashicorp/local/latest