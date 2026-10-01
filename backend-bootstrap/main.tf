# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "a3adf20e-4966-4afb-b717-4de1baae6db1"
  use_cli         = true # Bruker pålogging via `az login`

  # Fra og med azurerm 5.0 registreres ingen resource providers automatisk
  resource_providers_to_register = ["Microsoft.Storage"]
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-tfstate-oleksako"
  location = "westeurope"
  tags     = { "keep" = "true" }
}

resource "azurerm_storage_account" "sa" {
  name                     = "sttfstateoleksako01" # må være globalt unikt
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_container" "sc" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
}

data "azurerm_client_config" "current" {}

# Tilgang slik at innlogget bruker kan liste innholdet i containeren
resource "azurerm_role_assignment" "blob_reader" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id

  # Sørg for at SA og container er ferdig opprettet før RBAC forsøkes
  depends_on = [
    azurerm_storage_account.sa,
    azurerm_storage_container.sc
  ]
}

variable "pipeline_principal_id" {
  description = "Object-ID til service principal-en workflowen logger inn som"
  type        = string
}

resource "azurerm_role_assignment" "kv_user_pipeline" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.pipeline_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "pipeline_blob_contributor" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.pipeline_principal_id
  principal_type       = "ServicePrincipal"

  depends_on = [
    azurerm_storage_account.sa,
    azurerm_storage_container.sc
  ]
}
