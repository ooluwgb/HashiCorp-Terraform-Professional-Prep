output "instance_id" {
    value       = aws_instance.main.id
    description = "This is the ID of the EC2 instance that was created"
}

output "vpc_id" {
    value       = aws_vpc.main.id
    description = "This is the ID of the VPC that was created"
} 

output "vpc_cidr" {
    value       = aws_vpc.main.cidr_block
    description = "This is the CIDR block of the VPC that was created"
} 

output "subnet_id" {
    value       = aws_subnet.main.id
    description = "This is the ID of the subnet that was created"
}

output "subnet_cidr" {
    value       = aws_vpc.main.cidr_block
    description = "This is the CIDR block of the subnet that was created"
}
