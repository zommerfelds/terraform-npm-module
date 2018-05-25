variable "stack_name" {
    default = "main"
}

locals {
    lambda_zip = "${path.module}/code.zip"
}

resource "aws_lambda_function" "code" {
    function_name = "${var.stack_name}-mymodule"
    handler = "code.handler"
    runtime = "nodejs8.10"
    filename = "${local.lambda_zip}"
    source_code_hash = "${base64sha256(file("${local.lambda_zip}"))}"
    role = "${aws_iam_role.lambda_exec_role.arn}"
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "${var.stack_name}-lambda_exec_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

output "function_arn" {
  value = "${aws_lambda_function.code.arn}"
}