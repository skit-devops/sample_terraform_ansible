### Deploy AWS Infrastructure and Configure with Ansible

1. **Deploy AWS Infrastructure:**
   - Navigate to the Terraform directory:
     ```bash
     cd terraform
     ```
   - Set the necessary values in the `terraform.tfvars` file.
   - Run the Terraform plan:
     ```bash
     terraform plan
     ```
   - If everything is correct, apply the Terraform configuration:
     ```bash
     terraform apply
     ```

2. **Run Ansible Playbook:**
   - Change to the Ansible directory:
     ```bash
     cd ../ansible
     ```
   - Run the Ansible playbook to install necessary tools and configurations:
     ```bash
     ansible-playbook -i '192.168.0.12,' -u ubuntu --private-key ~/.ssh/id_rsa --vault-password-file ~/.ssh/ansible-password.txt aws_main_ubuntu.yml
     ```
