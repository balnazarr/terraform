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

resource "aws_s3_bucket_notification" "event" {
  bucket = "${aws_s3_bucket.source.id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.lambda.arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".txt"
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${aws_s3_bucket.source.id}"

  topic {
    topic_arn     = "${aws_sns_topic.topic.arn}"
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".txt"
  }
}

resource "aws_sns_topic" "topic" {
  name = "s3-event-notification-topic"

  policy = <<-EOF
  {
    "Version":"2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "SNS:Publish",
        "Principal": {"AWS":"*"},
        "Resource": "arn:aws:sns:*:*:s3-event-notification-topic"
      }
    ]
  }
  EOF
}
