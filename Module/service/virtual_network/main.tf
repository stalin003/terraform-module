terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.73.0"
    }
  }

  required_version = ">= 1.5.7"
}


resource "azurerm_virtual_network" "vnet" {
  name                = var.network_name
  resource_group_name = var.resource_group_name
  location            = var.location

  address_space = [var.address_space]

  dynamic "subnet" {
    for_each = toset(var.subnet_names)

    content {
      name           = subnet.value
      address_prefix = lookup(local.subnet_names, subnet.value)
    }

  }


}