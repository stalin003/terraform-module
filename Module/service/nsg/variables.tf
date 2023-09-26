variable "resource_group_name" {
  default = "TestGroup"
  type    = string
}

variable "location" {
  default = "eastus"
  type    = string
}

variable "security_group_name" {
  default = "anime-nsg"
  type    = string
}

variable "security_rule" {
  default = [
    {
      name                       = "Allow-Http"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
  ]

  type = list(map(string))
}