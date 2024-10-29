resource "azurerm_subnet" "DB-subnet" {
  name = "${var.virtual-net}-${var.db_subnet-name}-${random_string.my-Rand.id}"
  resource_group_name = azurerm_resource_group.RG-1.name
  virtual_network_name = azurerm_virtual_network.My-Vnet.name
  address_prefixes = var.db_subnet-ip-addr
}
resource "azurerm_network_security_group" "my-db-NSG" {
  name = "${var.db_subnet-name}-NSG"
  location = azurerm_resource_group.RG-1.location
  resource_group_name = azurerm_resource_group.RG-1.name
}
locals {
  DB-port = {
    100 : 3306
    110 : 1403
    120 : 5432
  }
}

resource "azurerm_network_security_rule" "nsg-rule-DB" {
      for_each = local.DB-port
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
    network_security_group_name = azurerm_network_security_group.my-db-NSG.name

}
resource "azurerm_subnet_network_security_group_association" "db-with-nsg" {
  subnet_id = azurerm_subnet.DB-subnet.id
  network_security_group_id = azurerm_network_security_group.my-db-NSG.id
}