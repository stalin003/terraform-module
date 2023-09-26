variable "resource_group_name" {
  default = "TestResourceGroup"
  type    = string
}

variable "location" {
  default = "eastus"
  type    = string
}

variable "network_name" {
  default = "OnePiece"
  type    = string
}

variable "address_space" {
  default = "10.0.0.0/16"
  type    = string
}

variable "subnet_names" {
  default = ["GrandLine", "EastBlue"]
  type    = list(string)
}

variable "address_prefix" {
  default = ["10.0.10.0/24", "10.0.20.0/24"]
  type    = list(string)
}