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
  tags                = local.tags

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
  tags                = local.tags
  size                = var.vm_size
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_ed25519.pub")
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
