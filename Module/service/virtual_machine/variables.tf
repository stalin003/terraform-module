variable "vm_name" {
  default = "StrawHat"
  type    = string
}

variable "resource_group_name" {
  default = "TestGroup"
  type    = string
}

variable "location" {
  default = "eastus"
  type    = string
}

variable "size" {
  default = "Standard_B2s"
  type    = string
}

variable "computer_name" {
  default = "thousand-sunny"
  type    = string
}

variable "admin_username" {
  default = "luffy"
  type    = string
}

variable "admin_password" {
  default = ""
  type    = string
}

variable "public_key" {
  default = ""
  type    = string
}

variable "network_interface_id" {
  default = ""
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

variable "source_image_reference" {
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