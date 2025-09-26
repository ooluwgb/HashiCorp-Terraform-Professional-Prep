# SECTION ZERO

## AWS RESOURCES

* aws_instance
* aws_ami
* aws_launch_template
* aws_autoscaling_group
* aws_security_group
* aws_security_group_rule
* aws_s3_bucket
* aws_s3_object
* aws_caller_identity
* aws_iam_session_context
* aws_iam_policy_document
* aws_iam_role
* aws_subnet
* aws_vpc_security_group_ingress_rule
* aws_iam_instance_profile
* aws_iam_policy
* aws_iam_policy_attachment

---

## AWS INSTANCE

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_instance

An EC2 instance resource that provisions a virtual machine in AWS.

```hcl
resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}
```

---

## AWS AMI

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_ami

A data source to fetch Amazon Machine Images (AMIs) that can be used to launch instances.

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}
```

---

## AWS LAUNCH TEMPLATE

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_launch_template

Defines reusable launch parameters for EC2 instances (AMI, instance type, security groups, etc.).

```hcl
resource "aws_launch_template" "example" {
  name_prefix   = "example-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
}
```

---

## AWS AUTOSCALING GROUP

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_autoscaling_group

Manages a group of EC2 instances that scale automatically based on defined policies.

```hcl
resource "aws_autoscaling_group" "example" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.example.id]

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }
}
```

---

## AWS SECURITY GROUP

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_security_group

A virtual firewall controlling inbound and outbound traffic for AWS resources.

```hcl
resource "aws_security_group" "example" {
  name   = "example-sg"
  vpc_id = aws_vpc.example.id
}
```

---

## AWS SECURITY GROUP RULE

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_security_group_rule

Defines individual ingress or egress rules for a security group.

```hcl
resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.example.id
}
```

---

## AWS S3 BUCKET

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_s3_bucket

Manages an Amazon S3 bucket for object storage.

```hcl
resource "aws_s3_bucket" "example" {
  bucket = "my-example-bucket"
}
```

---

## AWS S3 OBJECT

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_s3_object

Manages objects (files) stored inside an S3 bucket.

```hcl
resource "aws_s3_object" "example" {
  bucket = aws_s3_bucket.example.id
  key    = "hello.txt"
  content = "Hello, World!"
}
```

---

## AWS CALLER IDENTITY

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_caller_identity

Retrieves details about the IAM identity used by Terraform to access AWS.

```hcl
data "aws_caller_identity" "current" {}
```

---

## AWS IAM SESSION CONTEXT

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_iam_session_context

Provides details about the IAM session context of the caller identity.

```hcl
data "aws_iam_session_context" "example" {
  arn = data.aws_caller_identity.current.arn
}
```

---

## AWS IAM POLICY DOCUMENT

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_iam_policy_document

Generates IAM policy documents in JSON format for use in IAM roles and policies.

```hcl
data "aws_iam_policy_document" "example" {
  statement {
    actions   = ["s3:ListAllMyBuckets"]
    resources = ["*"]
  }
}
```

---

## AWS IAM ROLE

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_iam_role

Manages IAM roles that grant permissions to AWS resources or entities.

```hcl
resource "aws_iam_role" "example" {
  name = "example-role"

  assume_role_policy = data.aws_iam_policy_document.example.json
}
```

---

## AWS SUBNET

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_subnet

Defines a subnet within a VPC.

```hcl
resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.1.0/24"
}
```

---

## AWS VPC SECURITY GROUP INGRESS RULE

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_vpc_security_group_ingress_rule

Manages individual ingress rules for a VPC security group.

```hcl
resource "aws_vpc_security_group_ingress_rule" "example" {
  security_group_id = aws_security_group.example.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}
```

---

## AWS IAM INSTANCE PROFILE

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_iam_instance_profile

Associates an IAM role with an EC2 instance.

```hcl
resource "aws_iam_instance_profile" "example" {
  name = "example-instance-profile"
  role = aws_iam_role.example.name
}
```

---

## AWS IAM POLICY

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_iam_policy

Manages custom IAM policies.

```hcl
resource "aws_iam_policy" "example" {
  name   = "example-policy"
  policy = data.aws_iam_policy_document.example.json
}
```

---

## AWS IAM POLICY ATTACHMENT

**TYPE:** AWS
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → DOCUMENTATION → aws_iam_policy_attachment

Attaches IAM policies to IAM users, groups, or roles.

```hcl
resource "aws_iam_policy_attachment" "example" {
  name       = "example-attachment"
  users      = []
  roles      = [aws_iam_role.example.name]
  policies   = [aws_iam_policy.example.arn]
}
```
