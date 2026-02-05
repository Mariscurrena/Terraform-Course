## The Hard-WAY
# resource "local_file" "products-1" {
#     content = "Product List for the next mounth"
#     filename = "products_${random_string.sufix-1.id}.txt" # e.g. called another resource: ${random_string.sufix.id}
# }
# resource "local_file" "products-2" {
#     content = "Product List for the next mounth"
#     filename = "products_${random_string.sufix-2.id}.txt" # e.g. called another resource: ${random_string.sufix.id}
# }
# resource "local_file" "products-3" {
#     content = "Product List for the next mounth"
#     filename = "products_${random_string.sufix-3.id}.txt" # e.g. called another resource: ${random_string.sufix.id}
# }
# resource "local_file" "products-4" {
#     content = "Product List for the next mounth"
#     filename = "products_${random_string.sufix-4.id}.txt" # e.g. called another resource: ${random_string.sufix.id}
# }
# resource "local_file" "products-5" {
#     content = "Product List for the next mounth"
#     filename = "products_${random_string.sufix-5.id}.txt" # e.g. called another resource: ${random_string.sufix.id}
# }

# Best Practice -- DRY: Don't Repeat Yourself
resource "local_file" "products" {
    count = 3
    content = "Product List for the next mounth"
    filename = "products_${random_string.sufix[count.index].id}.txt" # e.g. called another resource: ${random_string.sufix.id}
    # count.index -- Index nature, similar to a for bucle
}

#[=======================G-U-I-D-E=============================]#
# terraform init -- Just the first time to initialize the terraform instance
# terraform plan -- Creates a deployment plan, but doesn't apply it. Shows the changes
# terraform apply -- Creates a deployment plan and apply it. Shows the changes
# terraform destroy -- Destroy the elements created in a deployment
# terraform init -upgrade -- Update plugins and providers
# terraform show -- Shows the resources created for terraform
# terraform.tfstate -- Is a log with all the actions that have been perform by terraform

#[====================P-R-O-V-I-D-E-R==========================]#
# Random Provider - Interacts with the local instance, randomize a resource
# https://registry.terraform.io/providers/hashicorp/random/latest