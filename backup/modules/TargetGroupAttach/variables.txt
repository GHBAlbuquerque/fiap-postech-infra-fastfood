variable "target_group_arn" {
  type = string
  description = "arn of the created target group"
}

variable "target_id" {
  type = string
  description = "id of instance to attach"
}

variable "port" {
  type = string
  description = "port to call"
}