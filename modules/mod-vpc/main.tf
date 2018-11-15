resource "aws_vpc" "main" {
  cidr_block = "${var.subnet}"


  tags {
      Name = "Terra_VPC"
    }
}
