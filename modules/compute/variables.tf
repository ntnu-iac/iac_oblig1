variable "base_name" {
  type        = string
  description = "Felles navn som identifiserer alle ressursene i denne konfigurasjonen"
}

# variable "owner" {
#   type        = string
#   description = "Eier av ressursene, brukes i taggen Owner"
# }

# variable "enviroment" {
#   type        = string
#   description = "Miljøet ressursene tilhører (f.eks. dev eller prod), brukes i taggen Enviroment"
# }

# variable "managedby" {
#   type        = string
#   description = "Verktøyet som administrerer ressursene (f.eks. OpenTofu), brukes i taggen ManagedBy"
# }

# variable "rg_name" {
#   type        = string
#   description = "Navnet på ressursgruppen der NIC og VM opprettes"
# }

# variable "rg_location" {
#   type        = string
#   description = "Azure-regionen der NIC og VM opprettes"
# }

variable "snet_id" {
  type        = string
  description = "ID-en til subnettet som nettverkskortet til VM-en kobles til"
}

variable "vm_size" {
  type        = string
  description = "Størrelsen (SKU) på den virtuelle maskinen, f.eks. Standard_B2as_v2"
}

variable "username" {
  type        = string
  description = "Username"
}

variable "public_key" {
  type        = string
  description = "SSH key"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
}

variable "location" {
  type        = string
  description = "Azure-regionen ressursene opprettes i"
}
