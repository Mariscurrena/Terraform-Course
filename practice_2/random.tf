# Hard WAY
# resource "random_string" "sufix-1" {
#     length  = 6
#     special = false
#     upper = false
#     numeric = false # Number is deprecated
# }
# resource "random_string" "sufix-2" {
#     length  = 6
#     special = false
#     upper = false
#     numeric = false # Number is deprecated
# }
# resource "random_string" "sufix-3" {
#     length  = 6
#     special = false
#     upper = false
#     numeric = false # Number is deprecated
# }
# resource "random_string" "sufix-4" {
#     length  = 6
#     special = false
#     upper = false
#     numeric = false # Number is deprecated
# }
# resource "random_string" "sufix-5" {
#     length  = 6
#     special = false
#     upper = false
#     numeric = false # Number is deprecated
# }

# Compliance with DRY -- Don't Repeat Yourself, better for scalability
resource "random_string" "sufix" {
    count = 3 #Indicates the quantity of times
    length  = 6
    special = false
    upper = false
    numeric = false # Number is deprecated
}