terraform {
  backend "s3" {
    bucket       = "ansible-terraform-integration-state-bucket-111000"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.18.0"
    }
  }
}

provider "aws" {
  region = var.region_name
}