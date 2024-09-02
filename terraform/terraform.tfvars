region      = "us-east-1"
environment = "dev"

vpc_name      = "vpc-dev"
domain_name   = "mydomain.com"
host_dns_name = "main-server"

ec2_ami         = "ami-0e83be366243f524a"
ec2_type        = "t3.medium"
ec2_volume_size = "50"
ec2_username    = "ubuntu"

public_key_path  = "~/.ssh/id_rsa.pub"
private_key_path = "~/.ssh/id_rsa"

ansible_inventory_path = "../../ansible_inventory"
ansible_playbook_name  = "aws_main_ubuntu.yml"