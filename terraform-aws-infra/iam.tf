data "aws_iam_policy_document" "ec2_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "app_server" {
  name               = "${var.project_name}-${var.environment}-app-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_trust.json
  description        = "IAM role for the Job Tracker application server"

  tags = {
    Name = "${var.project_name}-${var.environment}-app-role"
  }
}

resource "aws_iam_policy" "app_s3_access" {
  name        = "${var.project_name}-${var.environment}-s3-access"
  description = "Allows app server to read/write to its own S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.project_name}-${var.environment}-*",
          "arn:aws:s3:::${var.project_name}-${var.environment}-*/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "app_cloudwatch" {
  name        = "${var.project_name}-${var.environment}-cloudwatch"
  description = "Allows app server to write logs and metrics to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "cloudwatch:PutMetricData"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_s3" {
  role       = aws_iam_role.app_server.name
  policy_arn = aws_iam_policy.app_s3_access.arn
}

resource "aws_iam_role_policy_attachment" "app_cloudwatch" {
  role       = aws_iam_role.app_server.name
  policy_arn = aws_iam_policy.app_cloudwatch.arn
}

resource "aws_iam_role_policy_attachment" "app_ssm" {
  role       = aws_iam_role.app_server.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "app_server" {
  name = "${var.project_name}-${var.environment}-app-profile"
  role = aws_iam_role.app_server.name
}

