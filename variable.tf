variable "name" {}
variable "storage_account" {}
variable "vnet" {}
variable "subnet" {}
variable "pip" {}
variable "nic" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    # vnet_name           = string
    subnet_name = string
    subnet_key  = string
    pip_key     = string
    ip_configuration = list(object({
      name                          = string
      private_ip_address_allocation = string
    }))
  }))
}
variable "vm" {
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    
    size                            = string
    admin_username                  = string
    admin_password                  = string
    disable_password_authentication = bool

  }))
}