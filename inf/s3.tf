#----------------------------------------------------------------
# S3 buckets
#----------------------------------------------------------------

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


#----------------------------------------------------------------
# Bucket events
#----------------------------------------------------------------

resource "aws_s3_bucket_notification" "event" {
  bucket = "${aws_s3_bucket.source.id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.lambda.arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".txt"
  }
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda.arn}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${aws_s3_bucket.source.arn}"
}
