variable "base_name" {
  type        = string
  description = "Felles navn som identifiserer alle ressursene i denne konfigurasjonen"
}

variable "location" {
  type        = string
  description = "Azure-regionen ressursene opprettes i"
}

variable "address_space" {
  type        = string
  description = "Adresserommet til det virtuelle nettverket i CIDR-notasjon, f.eks. 10.10.0.0/16"
}

variable "address_prefixes" {
  type        = map(number)
  description = "Subnett som skal opprettes: navn => netnum innenfor adresserommet"
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

variable "tags" {
  type        = map(string)
  description = "Tags"
}
