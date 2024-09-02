resource "null_resource" "ansible_playbook" {
  depends_on = [aws_instance.ec2]

  provisioner "local-exec" {
    working_dir = "../ansible"
    command     = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${aws_instance.ec2.private_ip}, ' -u ${var.ec2_username} --private-key ${var.private_key_path} --vault-password-file ~/.ssh/ansible-password.txt ${var.ansible_playbook_name}"
  }
}

resource "null_resource" "ansible_inventory" {

  triggers = {
    ec2_name = aws_instance.ec2.tags_all.Name
    ec2_ip   = aws_instance.ec2.private_ip
  }

  provisioner "local-exec" {
    command = "${path.module}/files/inventory.sh"
    environment = {
      ansible_inventory = var.ansible_inventory_path
      host_name         = self.triggers.ec2_name
      host_ip           = self.triggers.ec2_ip
      host_user         = var.ec2_username
      host_ssh          = var.private_key_path
    }
  }
}

resource "null_resource" "ansible_inventory_remove" {
  depends_on = [aws_instance.ec2]

  triggers = {
    ec2_name          = aws_instance.ec2.tags_all.Name
    ec2_ip            = aws_instance.ec2.private_ip
    ec2_user          = var.ec2_username
    ec2_ssh           = var.private_key_path
    ansible_inventory = var.ansible_inventory_path
  }

  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/files/inventory.sh destroy"
    environment = {
      ansible_inventory = self.triggers.ansible_inventory
      host_name         = self.triggers.ec2_name
      host_ip           = self.triggers.ec2_ip
      host_user         = self.triggers.ec2_user
      host_ssh          = self.triggers.ec2_ssh
    }
    on_failure = continue
  }
}