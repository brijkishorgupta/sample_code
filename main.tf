resource "azurerm_resource_group" "rgs" {

  for_each = var.name
  name     = each.value.name
  location = each.value.location
}

resource "azurerm_storage_account" "sa" {
  depends_on = [azurerm_resource_group.rgs]

  for_each                 = var.storage_account
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}

resource "azurerm_virtual_network" "vnet" {
  depends_on          = [azurerm_resource_group.rgs]
  for_each            = var.vnet
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  address_space       = each.value.address_space

}
resource "azurerm_subnet" "subnet" {
    depends_on = [ azurerm_resource_group.rgs , azurerm_virtual_network.vnet ]

  for_each             = var.subnet
  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_public_ip" "pip" {
    depends_on = [ azurerm_resource_group.rgs ]

  for_each            = var.pip
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
}

resource "azurerm_network_interface" "nic" {
    depends_on = [ azurerm_resource_group.rgs, azurerm_subnet.subnet, azurerm_public_ip.pip ]

  for_each            = var.nic
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  ip_configuration {

    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[each.value.subnet_key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[each.value.pip_key].id

  }
}

resource "azurerm_linux_virtual_machine" "vm" {
    depends_on = [ azurerm_resource_group.rgs, azurerm_virtual_network.vnet, azurerm_subnet.subnet, azurerm_public_ip.pip, azurerm_network_interface.nic ]

  for_each                        = var.vm
  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = each.value.disable_password_authentication
  network_interface_ids           = [azurerm_network_interface.nic["nic1"].id]

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
    