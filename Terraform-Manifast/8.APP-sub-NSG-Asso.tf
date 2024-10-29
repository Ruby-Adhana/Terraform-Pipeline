resource "azurerm_subnet" "App-subnet" {
  name = "${var.virtual-net}-${var.app_subnet-name}-${random_string.my-Rand.id}"
  resource_group_name = azurerm_resource_group.RG-1.name
  virtual_network_name = azurerm_virtual_network.My-Vnet.name
  address_prefixes = var.app_subnet-addr
}
resource "azurerm_network_security_group" "my-app-NSG" {
  name = "${var.app_subnet-name}-NSG"
  location = azurerm_resource_group.RG-1.location
  resource_group_name = azurerm_resource_group.RG-1.name
}
locals {
  app-port = {
    100 : 80
    110 : 443
    120 : 8080
    130 : 22
  }
}
resource "azurerm_network_security_rule" "nsg-rule-app" {
  for_each = local.app-port
    name                       = "allow-http-${each.value}" 
    priority                   =  each.key
    direction                  = "Inbound" 
    access                     = "Allow" 
    protocol                   = "Tcp" 
    source_port_range          = "*" 
    destination_port_range     = each.value
    source_address_prefix      = "*" 
    destination_address_prefix = "*" 
    resource_group_name = azurerm_resource_group.RG-1.name
    network_security_group_name = azurerm_network_security_group.my-app-NSG.name
}

resource "azurerm_subnet_network_security_group_association" "app-with-nsg" {
  subnet_id = azurerm_subnet.App-subnet.id
  network_security_group_id = azurerm_network_security_group.my-app-NSG.id
}