resource "azurerm_subnet" "Bestion_subnet" {
  name = "${var.virtual-net}-${var.bestion_subnet-name}-${random_string.my-Rand.id}"
  resource_group_name = azurerm_resource_group.RG-1.name
  virtual_network_name = azurerm_virtual_network.My-Vnet.name
  address_prefixes = var.bestion_subnet-ip-addr
}

resource "azurerm_network_security_group" "my-bestion-nsg" {
    name = "${var.bestion_subnet-name}-NSG"
    location = azurerm_resource_group.RG-1.location
    resource_group_name = azurerm_resource_group.RG-1.name
}

locals {
  bestion-port={
    100 : 22
    110 : 3389
  }
}
resource "azurerm_network_security_rule" "nsg-rule-bestion" {
  for_each = local.bestion-port
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
    network_security_group_name = azurerm_network_security_group.my-bestion-nsg.name
}
resource "azurerm_subnet_network_security_group_association" "bestion-with-nsg" {
     subnet_id = azurerm_subnet.Bestion_subnet.id
     network_security_group_id = azurerm_network_security_group.my-bestion-nsg.id
}