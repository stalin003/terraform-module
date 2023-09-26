output "network" {
  value = {
    id      = azurerm_virtual_network.vnet.id
    network = azurerm_virtual_network.vnet.name
    subnet  = azurerm_virtual_network.vnet.subnet
  }
}