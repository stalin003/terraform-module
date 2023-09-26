terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.73.0"
    }
  }

  required_version = ">= 1.5.7"
}

resource "azurerm_windows_virtual_machine" "vm" {

  count = var.is_linux ? 0 : 1

  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  computer_name       = var.computer_name
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    var.network_interface_id
  ]

  vtpm_enabled        = var.vtpm_enabled
  secure_boot_enabled = var.secure_boot

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  os_disk {
    storage_account_type = var.os_disk.storage_account_type
    caching              = var.os_disk.caching

  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics
  }

}

resource "azurerm_linux_virtual_machine" "vm" {

  count = var.is_linux ? 1 : 0

  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  computer_name       = var.computer_name
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.public_key
  }

  network_interface_ids = [
    var.network_interface_id
  ]

  vtpm_enabled        = var.vtpm_enabled
  secure_boot_enabled = var.secure_boot

  source_image_reference {
    publisher = var.linux_source_image_reference.publisher
    offer     = var.linux_source_image_reference.offer
    sku       = var.linux_source_image_reference.sku
    version   = var.linux_source_image_reference.version
  }

  os_disk {
    storage_account_type = var.os_disk.storage_account_type
    caching              = var.os_disk.caching

  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics
  }
}