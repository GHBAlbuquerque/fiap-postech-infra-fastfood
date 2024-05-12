terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  #  required_version = ">=0.14.9"

  backend "s3" {
    bucket  = "terraform-state-backend-postech-new"
    key     = "fiap-postech-infra-fastfood/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}


provider "aws" {
  region = "us-east-1"
}

