#arn:aws:iam::852237612097:user/dbrody
#----------------------------------------------------------------
# Provider
#----------------------------------------------------------------
provider "aws" {
  version = "~> 1.7"
  region  = "${var.region}"
#  assume_role {
#    role_arn = "arn:aws:iam::852237612097:role/dev-terraform-role"
#  }
}

#----------------------------------------------------------------
# Backend
#----------------------------------------------------------------
terraform {
  backend "s3" {
    bucket = "danny-terraform"
    key    = "network/vpc.tfstate"
    region = "us-west-2"
#    role_arn = "arn:aws:iam::852237612097:role/danny-terraform-role"
  }
}
