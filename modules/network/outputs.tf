output "subnet_ids" {
  value       = { for k, s in azurerm_subnet.snet : k => s.id }
  description = "Subnet-ID per subnettnavn"
}

output "rgname" {
  value = azurerm_resource_group.rg.name
}

output "rglocation" {
  value = azurerm_resource_group.rg.location
}
