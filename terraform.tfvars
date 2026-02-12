name = {
  "rg1" = {
    name     = "triju"
    location = "west europe"
  }
  

}
storage_account = {
  "sa1" = {
    name                     = "trijustorageacc"
    resource_group_name      = "triju"
    location                 = "west europe"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
  
}

vnet = {

  "vnet1" = {
    name                = "triju-vnet1"
    resource_group_name = "triju"
    location            = "west europe"
    address_space       = ["10.0.0.0/16"]
  }
  
}
subnet = {
  "subnet1" = {
    name                 = "trijusubnet1"
    resource_group_name  = "triju"
    virtual_network_name = "triju-vnet1"
    address_prefixes     = ["10.0.1.0/24"]

  }

  
}
pip = {
  "pip1" = {
    name                = "trijupip1"
    resource_group_name = "triju"
    location            = "west europe"
    allocation_method   = "Static"
  }
}

nic = {
  "nic1" = {
    name                = "trijunic1"
    resource_group_name = "triju"
    location            = "west europe"
    subnet_name = "trijusubnet1"
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
    name                = "trijuvm1"
    resource_group_name = "triju"
    location            = "west europe"

    size                            = "Standard_D2s_v5"
    admin_username                  = "azureuser"
    admin_password                  = "Azure12345678"
    disable_password_authentication = false
  }
}

