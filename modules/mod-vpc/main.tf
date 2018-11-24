#----------------------------------------------------------------
# locals + data
#----------------------------------------------------------------

locals{
   vpc_cidr = "${var.vpc_cidr}"

   general = "${cidrsubnet(local.vpc_cidr, 6, 2 )}"
   access  = "${cidrsubnet(local.vpc_cidr, 6, 1 )}"
   database = "${cidrsubnet(local.vpc_cidr, 6, 3 )}"
}

data "aws_availability_zones" "az" {}


#----------------------------------------------------------------
# VPC
#----------------------------------------------------------------


resource "aws_vpc" "main" {
  cidr_block           = "${local.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags {
      Name = "${var.name}-VPC"
  }
}


#----------------------------------------------------------------
# Subnets
#----------------------------------------------------------------

module "general-subnet" {
  source  = "../mod-subnet"

  vpc_id  = "${aws_vpc.main.id}"
  cidr    = "${local.general}"
  az_list = "${data.aws_availability_zones.az.names}" 
}
