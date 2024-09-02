# Utils-Sandbox Server Role
Ansible role to install and configure main server on Ubuntu 22.04

#### run playbook
```
ansible-playbook -i '192.168.0.12, ' -u ubuntu --private-key ~/.ssh/id_rsa --vault-password-file ~/.ssh/ansible-password.txt aws_main_ubuntu.yml
```