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
  default = "subnet-0a9a5b3113f41772a"
}

variable "subnet_id_b" {
  deafult = "subnet-023c0926286854cc1"
}

variable "subnet_id_c" {
  deafult = "subnet-06bfe0041e39d1b38"
}

variable "subnet_id_d" {
  deafult = "subnet-00decacbc2f6540ed"
}

variable "subnet_id_e" {
  deafult = "subnet-0cc96aea146f03bc4"
}