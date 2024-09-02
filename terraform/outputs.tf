
output "instance_name" {
  description = "EC2 instance, security_group name"
  value       = aws_instance.ec2.tags
}

output "instance_type" {
  description = "EC2 instance instance_type"
  value       = aws_instance.ec2.instance_type
}

output "volume_size" {
  description = "Root volume size"
  value       = aws_instance.ec2.root_block_device.*.volume_size
}

output "host_name" {
  value = aws_route53_record.hostname.name
}

output "ssh_user" {
  value = var.ec2_username
}

output "ssh" {
  value = "ssh -i ${var.private_key_path} ${var.ec2_username}@${aws_instance.ec2.private_ip}"
}

output "ssh_private_key" {
  value = var.private_key_path
}

output "static_public_ip" {
  description = "List of static public IP addresses assigned to the instances from AWS pool"
  value       = aws_eip.new_ip.public_ip
}

output "static_private_ip" {
  description = "List of static public IP addresses assigned to the instances from AWS pool"
  value       = aws_instance.ec2.private_ip
}

output "ansible_host_link" {
  description = "This link is going to add to /etc/ansible/ansible_inventory host file for ansible connect to server after successful terraform installed process"
  value       = aws_instance.ec2.tags_all.AnsibleHost
}

output "image_id" {
  value = data.aws_ami.ubuntu22.id
}

output "ec2_name" {
  value = aws_instance.ec2.tags_all.Name
}
