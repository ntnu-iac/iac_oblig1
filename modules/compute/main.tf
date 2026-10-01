terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
}

resource "azurerm_network_interface" "nic" {
  name                = format("nic-%s", lower(var.base_name))
  location            = var.rg_location
  resource_group_name = var.rg_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.snet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = format("vm-%s", lower(var.base_name))
  resource_group_name = var.rg_name
  location            = var.rg_location
  tags                = var.tags
  size                = var.vm_size
  admin_username      = var.username
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = var.username
    public_key = var.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
