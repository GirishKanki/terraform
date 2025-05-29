#create iam user and attch customer ,amaged policy
resource "aws_iam_user" "user" {
  name = "girish-user"

  tags = {
    Environment = "test"
  }
}

resource "aws_iam_policy" "policy" {
  name        = "S3-girish-Policy"
  description = "Custom policy for example-user"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ],
        Resource = "*"
      }
    ]
  })

  tags = {
    Environment = "test"
  }
}

resource "aws_iam_user_policy_attachment" "example_user_policy_attach" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}