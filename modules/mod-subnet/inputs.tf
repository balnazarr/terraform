variable "name" {}

variable "vpc_id" {}
variable "cidr" {}

variable "create" { default = true }
variable "az_list" { type = "list" }
variable "public_ips" { default = false }
