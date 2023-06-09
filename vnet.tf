resource "azurecaf_name" "lz-networking-resource-group-name" {
  resource_type = "azurerm_resource_group"
  name          = "${var.project-name}-networking"
  prefixes      = concat(var.resource-prefixes, ["lz"])
  suffixes      = var.resource-suffixes
}

resource "azurerm_resource_group" "lz-networking-resource-group" {
  name     = azurecaf_name.lz-networking-resource-group-name.result
  location = var.location
}

resource "azurecaf_name" "lz-networking-vnet-name" {
  resource_type = "azurerm_virtual_network"
  name          = var.project-name
  prefixes      = var.resource-prefixes
  suffixes      = var.resource-suffixes
}

resource "azurerm_virtual_network" "lz-networking-vnet" {
  name                = azurecaf_name.lz-networking-vnet-name.result
  resource_group_name = azurerm_resource_group.lz-networking-resource-group.name
  address_space       = var.vnet-address-space
  location            = var.location
}

resource "azurerm_virtual_network_dns_servers" "lz-networking-vnet-dns" {
  count = var.dns-servers == null ? 0 : 1

  virtual_network_id = azurerm_virtual_network.lz-networking-vnet.id
  dns_servers        = var.dns-servers
}
