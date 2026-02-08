resource "azurerm_resource_group" "rgs" {
  name     = "rg-lattu"
  location = "central india"
}
# implecit dependency
resource "azurerm_storage_account" "storage" {
  name                     = "storagelattu"
  resource_group_name      = azurerm_resource_group.rgs.name
  location                 = azurerm_resource_group.rgs.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
# explicit dependency
resource "azurerm_virtual_network" "vnet" {
  depends_on          = [azurerm_resource_group.rgs]
  name                = "vnet-lattu"
  address_space       = ["10.0.0.0/16"]
  location            = "central india"
  resource_group_name = "rg-lattu"
}

resource "azurerm_subnet" "subnet" {
  depends_on           = [azurerm_resource_group.rgs, azurerm_virtual_network.vnet]
  name                 = "subnet-lattu"
  resource_group_name  = "rg-lattu"
  virtual_network_name = "vnet-lattu"
  address_prefixes     = ["10.0.1.0/24"]
}
# emplicit dependency
resource "azurerm_public_ip" "pip" {
  name                = "pip-lattu"
  location            = azurerm_resource_group.rgs.location
  resource_group_name = azurerm_resource_group.rgs.name
  allocation_method   = "Static"
}
# explict dependency
resource "azurerm_network_interface" "nic" {
  name                = "nic-lattu"
  location            = "central india"
  resource_group_name = "rg-lattu"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}
# explict dependency
resource "azurerm_linux_virtual_machine" "vn" {
    depends_on = [ azurerm_resource_group.rgs , azurerm_network_interface.nic , azurerm_public_ip.pip , azurerm_virtual_network.vnet ,azurerm_subnet.subnet,  ]
  name                            = "vm-lattu"
  resource_group_name             = "rg-lattu"
  location                        = "central india"
  size                            = "Standard_D2s_v5"
  admin_username                  = "adminuser"
  admin_password                  = "Admin@123"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}