resource "aws_iam_role" "cp_b00_iam_s3_access_for_ec2" {
  name = "cp_b00_s3_access"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

}


resource "aws_iam_role_policy" "cp_b00_s3_access" {
  name = "s3_access_limited"
  role = aws_iam_role.cp_b00_iam_s3_access_for_ec2.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListAllMyBuckets",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Effect : "Allow"
        Resource = ["arn:aws:s3:::cp-b00-s3-bucket", "arn:aws:s3:::cp-b00-s3-bucket/*"]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "cp_b00_instance_profile" {
  name = "cp-b00-instnace-profile"
  role = aws_iam_role.cp_b00_iam_s3_access_for_ec2.name
}