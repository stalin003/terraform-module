variable "resource_group_name" {
  default = "AnimeResourceGroup"
  type    = string
}

variable "location" {
  default = "eastus"
  type    = string
}

variable "vm_name" {
  default = [["StrawHat", "Kaido"], ["Naruto"]]
  type    = list(list(string))
}

variable "computer_name" {
  default = ["Thousand-Sunny", "Beast-Pirate", "Team-7"]
}

variable "nsg_name" {
  default = "anime-nsg"
  type    = string
}

variable "security_rule" {
  default = [
    {
      name                       = "Allow-SSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
  ]

  type = list(map(string))
}

variable "network_name" {
  default = ["OnePiece", "Naruto"]
  type    = list(string)
}

variable "address_space" {
  default = ["10.0.0.0/16", "10.10.0.0/16"]
  type    = list(string)
}

variable "subnet_names" {
  default = [["GrandLine", "EastBlue"], ["HiddenLeaf"]]
  type    = list(list(string))
}

variable "address_prefix" {
  default = [["10.0.10.0/24", "10.0.20.0/24"], ["10.10.10.0/24"]]
  type    = list(list(string))
}

variable "size" {
  default = "Standard_B2s"
  type    = string
}

variable "vtpm_enabled" {
  default = true
  type    = bool
}

variable "secure_boot" {
  default = true
  type    = bool
}

variable "windows_source_image_reference" {
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-datacenter-gensecond"
    version   = "latest"
  }

  type = map(string)
}

variable "linux_source_image_reference" {
  default = {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  type = map(string)
}

variable "os_disk" {
  default = {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"

  }
  type = map(string)
}

variable "boot_diagnostics" {
  default = ""
  type    = string
}

variable "is_linux" {
  default = true
  type    = bool
}