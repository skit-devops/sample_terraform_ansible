resource "aws_key_pair" "auth" {
  key_name   = local.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "ec2" {
  instance_type               = var.ec2_type
  ami                         = var.ec2_ami
  key_name                    = local.key_name
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  subnet_id                   = data.aws_subnets.public.ids[0]
  iam_instance_profile        = aws_iam_instance_profile.ec2.name
  monitoring                  = false
  disable_api_termination     = true
  ebs_optimized               = false
  associate_public_ip_address = true

  credit_specification {
    cpu_credits = "standard"
  }
  root_block_device {
    volume_size           = var.ec2_volume_size
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = false
  }


  # force Terraform to wait until a connection can be made, so that Ansible doesn't fail when trying to provision
  provisioner "remote-exec" {
    # The connection will use the local SSH agent for authentication
    inline = [
      "echo Successfully connected",
      "sudo hostnamectl set-hostname ${local.route53_name}"
    ]

    # The connection block tells our provisioner how to communicate with the resource (instance)
    connection {
      type        = "ssh"
      user        = var.ec2_username
      host        = self.private_ip
      private_key = file(var.private_key_path)
    }
  }
}
