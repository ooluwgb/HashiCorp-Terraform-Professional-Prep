# Outputs from aws_vpc "count" resources
output "vpc_0_ID" {
    value = aws_vpc.count[0].id   # ID of the first VPC
}

output "vpc_1_ID" {
    value = aws_vpc.count[1].id   # ID of the second VPC
}

# Outputs from aws_iam_user "for_each" resources
output "User_1" {
    value = aws_iam_user.for_each["User_1"].name   # IAM User 1
}

output "User_2" {
    value = aws_iam_user.for_each["User_2"].name   # IAM User 2
}

# Outputs from west provider resources
output "VPC_West_Provider_ID" {
    value = aws_vpc.west_provider.id
}

output "Subnet_West_Provider_ID" {
    value = aws_subnet.west_provider.id
}

# Outputs from east provider resources
output "VPC_East_Provider_ID" {
    value = aws_vpc.east_provider.id
}

output "Subnet_East_Provider_ID" {
    value = aws_subnet.east_provider.id
}

# Output from S3 bucket lifecycle example
output "S3_Bucket_Name" {
    value = aws_s3_bucket.lifecycle.bucket
}

# Output from IAM user and IAM policy attachment
output "Test_User" {
    value = aws_iam_user.test_user.name
}

output "aws_iam_user_policy_attachment_arn" {
    value = aws_iam_user_policy_attachment.depends_on.id   # ID of IAM policy attachment
}

# Output from EC2 instance created with data source
output "Instance_ID" {
    value = aws_instance.example.id
}
