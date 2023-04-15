resource "aws_iam_policy" "additional" {
  name = "${local.name}-additional"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "cqlsh_access_role" {
  name = "cqlsh-access-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "cqlsh_access_policy" {
  name = "cqlsh-access-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "keyspaces:Connect",
          "keyspaces:DescribeClusters",
          "keyspaces:ExecuteStatements",
          "keyspaces:DescribeKeyspaces"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cqlsh_access_role_policy_attachment" {
  policy_arn = aws_iam_policy.cqlsh_access_policy.arn
  role       = aws_iam_role.cqlsh_access_role.name
}
