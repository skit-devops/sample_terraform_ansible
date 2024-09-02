terraform {
  required_version = "> 1.4.2"

  required_providers {
    aws = {
      version = "5.28.0"
      source  = "hashicorp/aws"
    }
    ansible = {
      version = "~> 1.1.0"
      source  = "ansible/ansible"
    }
    null = {
      version = "~> 3.2.2"
      source  = "hashicorp/null"
    }
  }
}

terraform {
  backend "s3" {
    bucket  = "terraform-bucket"
    key     = "dev/main_ubuntu.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

# Specify the provider and access details
provider "aws" {
  region = var.region
  default_tags {
    tags = local.default_tags
  }
}
