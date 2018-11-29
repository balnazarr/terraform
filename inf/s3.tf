resource "random_integer" "rnd" {
  min     = 500
  max     = 600
}

resource "random_integer" "rnd2" {
  min     = 800
  max     = 900
}

resource "aws_s3_bucket" "source" {
  bucket = "${var.s3_src}-${random_integer.rnd.result}"
  region = "${var.region}"  

  acl = "private"
}

resource "aws_s3_bucket" "target" {
  bucket = "${var.s3_dest}-${random_integer.rnd2.result}"
  region = "${var.region}"

  acl = "private"
}

/*
resource "aws_s3_bucket_notification" "event" {
  bucket = "${aws_s3_bucket.test.id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.func.arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".txt"
  }
}
*/
