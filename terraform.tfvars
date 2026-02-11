name = {
  "rg1" = {
    name     = "briju"
    location = "west europe"
  }
  

}
storage_account = {
  "sa1" = {
    name                     = "brijustorageacc"
    resource_group_name      = "briju"
    location                 = "west europe"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
  
}

vnet = {

  "vnet1" = {
    name                = "brijuvnet1"
    resource_group_name = "briju"
    location            = "west europe"
    address_space       = ["10.0.0.0/16"]
  }
  
}
subnet = {
  "subnet1" = {
    name                 = "brijusubnet1"
    resource_group_name  = "briju"
    virtual_network_name = "brijuvnet1"
    address_prefixes     = ["10.0.1.0/24"]

  }

  
}
pip = {
  "pip1" = {
    name                = "brijupip1"
    resource_group_name = "briju"
    location            = "west europe"
    allocation_method   = "Static"
  }
}

nic = {
  "nic1" = {
    name                = "brijunic1"
    resource_group_name = "briju"
    location            = "west europe"
    subnet_name = "brijusubnet1"
    subnet_key  = "subnet1"
    pip_key     = "pip1"
    ip_configuration = [
      {

        name                          = "internal"
        private_ip_address_allocation = "Dynamic"
      }
    ]
  }
}

vm = {
  "vm1" = {
    name                = "brijuvm1"
    resource_group_name = "briju"
    location            = "west europe"

    size                            = "Standard_B1s"
    admin_username                  = "azureuser"
    admin_password                  = "Azure12345678"
    disable_password_authentication = false
  }
}

