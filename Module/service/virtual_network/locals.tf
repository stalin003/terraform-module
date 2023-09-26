locals {
  subnet_names = zipmap(var.subnet_names, var.address_prefix)
}
