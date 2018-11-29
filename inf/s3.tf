resource "random_integer" "rnd" {
  min     = 500
  max     = 600
}

resource "aws_s3_bucket" "test" {
  bucket = "${var.s3_name}-${random_integer.rnd.result}"
  acl = "private"
  region = "${var.region}"  
}
