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
  default = "lambda_arn"
}

variable "lab_role_arn" {
  default = "labrole_arn"
}

variable "vpc_id" {
  default = "vpc-id"
}

variable "vpc_cidr_block" {
  default = "0.0.0.0/0"
}

variable "subnet_id_a" {
  default = "subnet-a"
}

variable "subnet_id_b" {
  default = "subnet-b"
}

variable "subnet_id_c" {
  default = "subnet-c"
}

variable "subnet_id_d" {
  default = "subnet-d"
}

variable "subnet_id_e" {
  default = "subnet-e"
}

variable "instance_type" {
  default = "t3.medium"
}