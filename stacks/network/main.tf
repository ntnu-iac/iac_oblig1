terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }

  backend "azurerm" {}

}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  use_cli = true # Bruker pålogging via `az login`

  # Fra og med azurerm 5.0 registreres ingen resource providers automatisk
  resource_providers_to_register = ["Microsoft.Storage"]
}

locals {
  base_name = "${var.enviroment}${var.prefiks}"
  tags = {
    owner      = var.owner
    managedby  = var.managedby
    enviroment = var.enviroment
  }
}

module "vnet" {
  source           = "../../modules/network"
  base_name        = local.base_name
  location         = var.location
  address_space    = var.address_space
  address_prefixes = var.address_prefixes
  tags             = local.tags
}

# module "compute" {
#   source      = "../../modules/compute"
#   base_name   = local.base_name
#   tags        = local.tags
#   rg_name     = module.vnet.rgname
#   rg_location = module.vnet.rglocation
#   snet_id     = module.vnet.subnet_ids[var.subnet_key]
#   vm_size     = var.vm_size
#   username    = var.username
#   public_key  = var.public_key
# }

# module "stack" {
#   source = "../../stacks"

#   prefiks          = var.owner
#   location         = var.location
#   address_space    = var.address_space
#   address_prefixes = var.address_prefixes
#   owner            = var.owner
#   managedby        = var.managedby
#   enviroment       = var.enviroment
#   vm_size          = var.vm_size
#   subnet_key       = var.subnet_key
# }
