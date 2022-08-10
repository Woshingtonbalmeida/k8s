resource "azurerm_resource_group" "rg" {
  name     = "RG-RANCHER-EUA"
  location = var.location

  tags = local.common_tags
}
resource "azurerm_virtual_network" "vnet" {
  name                = "VNET-EUA"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "sub10" {
  name                 = "Subnet10"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic" {
  count               = 6
  name                = "VM-NIC-${var.vm-name[count.index]}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal-${var.vm-name[count.index]}"
    subnet_id                     = azurerm_subnet.sub10.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }
  tags = local.common_tags
}
resource "azurerm_public_ip" "pip" {
  count               = 6
  name                = "VM-PUBLIC-${var.vm-name[count.index]}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = "Dynamic"

  tags = local.common_tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  count                 = 6
  name                  = var.vm-name[count.index]
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  size                  = "Standard_b2s"
  admin_username        = "wbatista"
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  custom_data           = filebase64("customdata.tpl")
  admin_ssh_key {
    username   = "wbatista"
    public_key = file("./azure-key.pub")
  }

  os_disk {
    disk_size_gb         = var.disk_size_gb[count.index]
    name                 = var.vm-name[count.index]
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  tags = local.common_tags
}
