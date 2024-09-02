# Allocate new address
resource "aws_eip" "ec2" {
  domain = "vpc"
}

# Assigned IP address to ec2 instance
resource "aws_eip_association" "ec2" {
  instance_id   = aws_instance.ec2.id
  allocation_id = aws_eip.ec2.id
}
