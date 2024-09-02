# the instances over SSH and HTTP/HTTPS
resource "aws_security_group" "ec2" {
  name        = "${var.host_dns_name}-sg-${var.environment}"
  description = "Security Group for ${var.host_dns_name} in ${var.environment} env"
  vpc_id      = data.aws_vpc.existing_vpc.id

  # SSH access from anywhere
  ingress {
    description = "Open ssh port for VPN"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["1.2.3.4/32", "5.6.7.8/32"]
  }

  # Zabbix access
  ingress {
    description = "Access for monitoring server"
    from_port   = 10050
    to_port     = 10050
    protocol    = "tcp"
    cidr_blocks = ["12.34.56.78/32"]
  }

  # HTTP/HTTPS access from anywhere
  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      description = "Open http/https for all"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
