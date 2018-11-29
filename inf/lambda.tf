resource "aws_lambda_function" "lambda" {
  filename         = "danny-lambda.zip"
  function_name    = "lambda_function"
  role             = "${aws_iam_role.lambda.arn}"
  handler          = "exports.test"
  source_code_hash = "${base64sha256(file("danny-lambda.zip"))}"
  runtime          = "python3.6"
}
