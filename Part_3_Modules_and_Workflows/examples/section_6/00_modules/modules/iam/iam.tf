#################################################################################
###### CALLER IDENTITY AND SESSION CONTEXT
#################################################################################

# Caller identity
data "aws_caller_identity" "current" {}

# Session context
data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}


#################################################################################
###### IAM POLICY AND ATTACHMENTS
#################################################################################

# Policy document
data "aws_iam_policy_document" "s3_policy_document" {
  statement {
    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
  }
}

# IAM policy
resource "aws_iam_policy" "s3_policy" {
  name   = "example_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.s3_policy_document.json
}

# IAM user
resource "aws_iam_user" "test_user" {
  for_each = var.User_Name
  name = each.value
}

# IAM policy attachment for the user
resource "aws_iam_user_policy_attachment" "depends_on" {
  for_each = var.User_Name
  user       = each.value
  policy_arn = aws_iam_policy.s3_policy.arn
}


#################################################################################
###### IAM ROLE AND INSTANCE PROFILE
#################################################################################

# IAM role
resource "aws_iam_role" "ec2_role" {
  name = "test_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "EC2_Role"
  }
}

# IAM instance profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2_Instance_Profile"
  role = aws_iam_role.ec2_role.name
}


#################################################################################
###### IAM ROLE POLICY TO DESCRIBE EC2 FOR THE ROLE ABOVE
#################################################################################

resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"
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

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.policy.arn
}
