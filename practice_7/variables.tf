# Best Practice: Have a specific var file.
### Just variable definition, not init params
variable "virginia_cidr" {
  description = "Virginia CIDR"
  type        = string
  # sensitive = true
}

variable "subnets" {
  description = "Subnet's List"
  type        = list(string)
}

variable "tags" {
  description = "Project's tags"
  type        = map(string)
}

variable "sg_ingress_cidr" {
  description = "Traffic for Ingress CIDR"
  type        = string
}

variable "ec2_specs" {
  description = "Instance params"
  type        = map(string)
}

variable "enable_monitoring" {
  description = "Enable the monitoring instance deployment"
  # type = bool
  type = number
}