resource "aws_iam_role" "athena_exec_role" {
  name = "AthenaExecRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "athena.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy_attachment" "athena_exec_attach" {
  name       = "athena-s3-policy-attach"
  roles      = [aws_iam_role.athena_exec_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
