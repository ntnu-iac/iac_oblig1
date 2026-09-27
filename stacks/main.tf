terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
}

locals {
  base_name = "${var.enviroment}${var.prefiks}"
}

module "vnet" {
  source           = "../modules/network"
  base_name        = local.base_name
  location         = var.location
  address_space    = var.address_space
  address_prefixes = var.address_prefixes
  owner            = var.owner
  managedby        = var.managedby
  enviroment       = var.enviroment
}

module "compute" {
  source      = "../modules/compute"
  owner       = var.owner
  managedby   = var.managedby
  enviroment  = var.enviroment
  base_name   = local.base_name
  rg_name     = module.vnet.rgname
  rg_location = module.vnet.rglocation
  snet_id     = module.vnet.subnet_ids[var.subnet_key]
  vm_size     = var.vm_size
}
