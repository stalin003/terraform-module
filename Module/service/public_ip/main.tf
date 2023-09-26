terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.73.0"
    }
  }

  required_version = ">= 1.5.7"
}

resource "azurerm_public_ip" "ip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  ip_version          = "IPv4"
  sku                 = "Basic"
}
