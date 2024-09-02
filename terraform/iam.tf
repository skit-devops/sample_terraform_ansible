resource "aws_iam_role" "ec2" {
  name = "${var.host_dns_name}-EC2AccessRole-${var.environment}"

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

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.host_dns_name}-EC2InstanceRoleProfile-${var.environment}"
  role = aws_iam_role.ec2.name
}

resource "aws_iam_role_policy" "ec2" {
  name   = "${var.host_dns_name}-EC2AccessPolicy-${var.environment}"
  role   = aws_iam_role.ec2.name
  policy = file("${path.module}/files/ec2_policy.json")
}