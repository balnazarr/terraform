#----------------------------------------------------------------
# VPC
#----------------------------------------------------------------

module "vpc" {
  source = "modules/mod-vpc"
  region =  "${var.region}"
  name   =  "danny"
  vpc_cidr = "${var.vpc_cidr}"
}
