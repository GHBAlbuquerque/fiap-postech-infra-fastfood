variable "project_name" {
  default = "fiap-postech-fastfood"
}

variable "region" {
  default = "us-east-1"
}

variable "profile" {
  default = "default"
}

variable "accountid" {
  default = "067184771399"
}

variable "lambda_name" {
  default = "postech-lambda-auth-fastfood"
}

variable "lambda_arn" {
  default = "arn:aws:lambda:us-east-1:067184771399:function:postech-lambda-auth-fastfood"
}

variable "lab_role_arn" {
  default = "arn:aws:iam::067184771399:role/LabRole"
}

variable "vpc_id" {
  default = "vpc-0c33afcdadaa4be7b"
}

variable "vpc_cidr_block" {
  default = "172.31.0.0/16"
}

variable "subnet_id_a" {
  default = "subnet-092106de434121bca"
}

variable "subnet_id_b" {
  default = "subnet-021d5fd5534bb9fbd"
}

variable "subnet_id_c" {
  default = "subnet-05685364d9e045913"
}

variable "subnet_id_d" {
  default = "subnet-066ce0c3304da4788"
}

variable "subnet_id_e" {
  default = "subnet-0bdae3752039a482f"
}

variable "instance_type" {
  default = "t3.medium"
}