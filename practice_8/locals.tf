# 'Locals' is a terraform block that supports follow an specific nomenclature using a DRY approach
locals {
  sufix = "${var.tags.project}-${var.tags.env}-${var.tags.region}" #Resource-cerberus-prod-region
}

resource "random_string" "sufix-s3" {
  length  = 8
  special = false
  upper   = false
}

locals {
  s3-sufix = "${var.tags.project}-${random_string.sufix-s3.id}"
}