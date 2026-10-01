terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  # subscription_id = "38c12d6f-2edc-4e5c-8952-0b9c47fc4486"
  use_cli         = true # Bruker pålogging via `az login`

  # Fra og med azurerm 5.0 registreres ingen resource providers automatisk
  resource_providers_to_register = ["Microsoft.Storage"]
}

module "stack" {
  source = "../../stacks"

  prefiks          = var.owner
  location         = var.location
  address_space    = var.address_space
  address_prefixes = var.address_prefixes
  owner            = var.owner
  managedby        = var.managedby
  enviroment       = var.enviroment
  vm_size          = var.vm_size
  subnet_key       = var.subnet_key
}
