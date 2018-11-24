resource "aws_subnet" "main" {
  count                   = "${var.create ? length(var.az_list) : 0}"
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${cidrsubnet(var.cidr, 4, count.index)}"
  availability_zone       = "${element(var.az_list, count.index)}"
  map_public_ip_on_launch = "${var.public_ips ? true : false}"

  tags {
    Name = "${var.name}-${element(var.az_list, count.index)}"
  }
}
