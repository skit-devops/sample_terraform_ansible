variable "region" {
  description = "Default AWS region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_name" {
  description = "Existing Prod VPC name"
  type        = string
}

variable "public_key_path" {
  description = "Local ssh rsa.pub"
  type        = string
}

variable "private_key_path" {
  description = "Local ssh rsa"
  type        = string
}

# variable "key_name" {
#   description = "he name of our SSH keypair."
#   type        = string
# }

variable "domain_name" {
  description = "Platform Domain Name"
  type        = string
}

variable "host_dns_name" {
  description = "Hostname to create Route53 record"
  type        = string
}

variable "ec2_ami" {
  description = "Image for EC2"
  type        = string
}

variable "ec2_type" {
  description = "AWS EC2 instance type"
  type        = string
}

variable "ec2_volume_size" {
  description = "AWS EC2 instance volume size"
  type        = string
}

variable "ec2_username" {
  description = "AWS EC2 default username"
  type        = string
}

variable "ansible_inventory_path" {
  description = "Ansible inventory file path"
  type        = string
}

variable "ansible_playbook_name" {
  description = "Ansible playbook name"
  type        = string
}

locals {
  key_name     = local.default_tags.Name
  route53_name = "${var.host_dns_name}-${var.environment}.${var.domain_name}"

  default_tags = {
    Name        = "${var.host_dns_name}-${var.environment}"
    Cluster     = "No"
    Environment = var.environment
    Terraform   = true
    AnsibleHost = "aws_main_ubuntu"
  }
}