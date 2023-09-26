variable "resource_group_name" {
  default = "TestGroup"
  type    = string
}

variable "location" {
  default = "eastus"
  type    = string
}

variable "nic_name" {
  default = "anime-nic"
  type    = string
}

variable "public_ip_address_id" {
  default = ""
  type    = string
}

variable "subnet_id" {
  default = ""
  type    = string
}