resource "aws_lambda_function" "lambda" {
  filename         = "danny-lambda.zip"
  function_name    = "danny-s3-copy"
  role             = "${aws_iam_role.lambda.arn}"
  handler          = "lambda_function.lambda_handler"
  source_code_hash = "${base64sha256(file("danny-lambda.zip"))}"
  runtime          = "python3.6"
}
