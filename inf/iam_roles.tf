#----------------------------------------------------------------
# Terraform Role
#----------------------------------------------------------------

resource "aws_iam_role" "terraform_role" {
  name = "terraform_role"
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "TerraformAdmin",
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Principal": {
          "AWS" : [
            "arn:aws:iam::852237612097:user/dbrody"
          ]
        }
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "admin" {
  role = "${aws_iam_role.terraform_role.name}"
  policy_arn = "${aws_iam_policy.admin.arn}"
}


#----------------------------------------------------------------
# Lambda Role
#----------------------------------------------------------------

resource "aws_iam_role" "lambda" {
  name = "lambda_role"
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "LambdaRole",
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service" : "lambda.amazonaws.com" 
        }
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role = "${aws_iam_role.lambda.name}"
  policy_arn = "${aws_iam_policy.lambda.arn}"
}
