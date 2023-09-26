output "vm_ip" {
  value = var.is_linux ? {
    vm_name = azurerm_linux_virtual_machine.vm[0].name
    ip      = azurerm_linux_virtual_machine.vm[0].public_ip_address
    } : {
    vm_name = azurerm_windows_virtual_machine.vm[0].name
    ip      = azurerm_windows_virtual_machine.vm[0].public_ip_address
  }
}