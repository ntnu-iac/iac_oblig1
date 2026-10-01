variable "address_prefixes" {
  type        = map(number)
  description = "Subnett som skal opprettes: navn => netnum innenfor adresserommet"
}

variable "address_space" {
  type        = string
  description = "Adresserommet til det virtuelle nettverket i CIDR-notasjon, f.eks. 10.10.0.0/16"
}

variable "owner" {
  type        = string
  description = "Eier av ressursene, brukes i taggen Owner og som prefiks i ressursnavn"
}

variable "enviroment" {
  type        = string
  description = "Miljøet ressursene tilhører (f.eks. dev eller prod), brukes i taggen Enviroment og i ressursnavn"
}

variable "managedby" {
  type        = string
  description = "Verktøyet som administrerer ressursene (f.eks. OpenTofu), brukes i taggen ManagedBy"
}

# variable "vm_size" {
#   type        = string
#   description = "Størrelsen (SKU) på den virtuelle maskinen, f.eks. Standard_B2as_v2"
# }

variable "location" {
  type        = string
  description = "Azure-regionen ressursene opprettes i, f.eks. Norway East"
}

# variable "subnet_key" {
#   type        = string
#   description = "Navnet på subnettet (nøkkel i address_prefixes) som VM-en skal plasseres i"
# }

variable "prefiks" {
  type        = string
  description = "Unik prefiks"
}

# variable "username" {
#   type = string
#   description = "Username"
# }

# variable "public_key" {
#   type = string
#   description = "SSH key"
# }
