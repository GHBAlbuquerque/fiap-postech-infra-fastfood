variable "project_name" {
  default = "fiap-postech-fastfood"
}

variable "region" {
  default = "us-east-1"
}

variable "profile" {
  default = "default"
}

variable "lambda_name" {
  default = "postech-lambda-auth-fastfood"
}

variable "lambda_arn" {
  default = "arn:aws:lambda:us-east-1:211125478754:function:postech-lambda-auth-fastfood"
}

variable "lab_role_arn" {
  default = "arn:aws:iam::211125478754:role/LabRole"
}

variable "subnet_id_a" {
  default = "subnet-0226b059f9bb3e97b"
}

variable "subnet_id_b" {
  default = "subnet-094d8c1602642bf95"
}

variable "subnet_id_c" {
  default = "subnet-02a64d0abe9230131"
}

variable "subnet_id_d" {
  default = "subnet-096ff3a74878067c5"
}

variable "subnet_id_e" {
  default = "subnet-044446105935a3cd7"
}