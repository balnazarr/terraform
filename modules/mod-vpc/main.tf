locals{
   vpc_cidr = "${var.vpc_cidr}"

   general = "cidrsubnet(${local.vpc_cidr}, 6, 2 )"
   access  = "cidrsubnet(${local.vpc_cidr}, 6, 1 )"
   database = "cidrsubnet(${local.vpc_cidr}, 6, 3 )"
}

resource "aws_vpc" "main" {
  cidr_block = "${local.vpc_cidr}"

  tags {
      Name = "${var.name}-VPC"
  }
}
