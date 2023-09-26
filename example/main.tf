provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = var.resource_group_name
}

module "public_ip" {

  depends_on = [azurerm_resource_group.rg]

  for_each = toset(local.vm_name_flattern)

  source              = "../Module/service/public_ip"
  public_ip_name      = "${each.value}-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "network_security_group" {

  depends_on = [azurerm_resource_group.rg]

  source              = "../Module/service/nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
  security_group_name = var.nsg_name
  security_rule       = var.security_rule

}


module "network_nic" {

  depends_on = [
    azurerm_resource_group.rg,
    module.public_ip,
    module.virtual_network
  ]

  source = "../Module/service/nic"

  for_each = toset(local.vm_name_flattern)

  nic_name             = "${each.value}-nic"
  resource_group_name  = var.resource_group_name
  location             = var.location
  public_ip_address_id = lookup(module.public_ip, each.value).public_ip_address_id
  subnet_id            = lookup(local.subnet_id, lookup(local.map_vm_subnet_name, each.value))
}

module "virtual_network" {

  depends_on = [azurerm_resource_group.rg]

  for_each = toset(var.network_name)

  source              = "../Module/service/virtual_network"
  resource_group_name = var.resource_group_name
  location            = var.location
  network_name        = each.value
  address_space       = lookup(local.network, each.value)
  subnet_names        = lookup(local.subnet_names, each.value)
  address_prefix      = lookup(local.subnet_address_prefix, each.value)

}

resource "azurerm_network_interface_security_group_association" "nsg-assoc" {
  depends_on = [module.network_nic]

  for_each = toset(local.vm_name_flattern)

  network_interface_id      = lookup(local.nic_ids, each.value)
  network_security_group_id = local.nsg_id
}

module "virtual_machine" {
  source = "../Module/service/virtual_machine"

  depends_on = [
    module.network_nic
  ]
  for_each = toset(local.vm_name_flattern)

  is_linux            = var.is_linux
  vm_name             = each.value
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  computer_name       = lookup(local.computer_name, each.value)
  admin_username      = lower(each.value)
  public_key          = file("./id_rsa.pub")

  network_interface_id = lookup(local.nic_ids, each.value)

  vtpm_enabled = var.vtpm_enabled
  secure_boot  = var.secure_boot

  linux_source_image_reference = local.source_image_reference

  os_disk          = var.os_disk
  boot_diagnostics = var.boot_diagnostics

}

locals {
  vm_name_flattern      = flatten(var.vm_name)
  network               = zipmap(var.network_name, var.address_space)
  subnet_names          = zipmap(var.network_name, var.subnet_names)
  subnet_address_prefix = zipmap(var.network_name, var.address_prefix)
}

locals {
  subnet_id             = { for key, value in flatten([for key, value in module.virtual_network : value.network.subnet]) : value.name => value.id }
  subnet_names_flattern = flatten(var.subnet_names)

  map_vm_subnet_name = zipmap(local.vm_name_flattern, local.subnet_names_flattern)

  nic_ids = { for key, value in module.network_nic : key => value.nic_id }
  nsg_id  = module.network_security_group.nsg

  computer_name = zipmap(local.vm_name_flattern, var.computer_name)

  source_image_reference = var.is_linux ? var.linux_source_image_reference : var.windows_source_image_reference
}