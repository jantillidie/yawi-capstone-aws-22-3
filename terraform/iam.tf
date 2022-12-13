#====================================================
# IAM user, group, policy
#====================================================
resource "aws_iam_user" "terraform_user" {
  name = "terraform-user"
}

resource "aws_iam_access_key" "tf_user_key" {
  user = aws_iam_user.terraform_user.name
}

resource "aws_iam_policy" "terraform_policy" {
  name = "terraform-policy"
  path = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
          "s3:*",
          "iam:*",
          "lambda:*",
          "route53:*",
          "application-autoscaling:*",
          "cloudwatch:*",
          "dynamodb:*",
          "ecs:*",
          "acm:*",
          "elasticloadbalancing:*",
          "sns:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_user_policy_attachment" "tf_user_policy_attachment" {
  user       = aws_iam_user.terraform_user.name
  policy_arn = aws_iam_policy.terraform_policy.arn
}
