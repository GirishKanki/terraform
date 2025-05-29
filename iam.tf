
resource "aws_iam_user" "jhc" {
    name = "jhc-iam"

}
resource "aws_iam_policy_attachment" "iam" {
  users = [aws_iam_user.jhc.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadonlyAccess"
  name = "S3ReadOnlyAccess"
  
}
