terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = format("rg-%s", lower(var.base_name))
  location = var.location
  tags     = var.tags
}

resource "azurerm_network_security_group" "nsg" {
  name                = format("nsg-%s", lower(var.base_name))
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_virtual_network" "vnet" {
  name                = format("vnet-%s", lower(var.base_name))
  address_space       = [var.address_space]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

resource "azurerm_subnet" "snet" {
  for_each = var.address_prefixes

  name                 = format("snet-%s", lower(each.key))
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.address_space, 8, each.value)]
}

resource "azurerm_subnet_network_security_group_association" "nsga" {
  for_each = azurerm_subnet.snet

  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
