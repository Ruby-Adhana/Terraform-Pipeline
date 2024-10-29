# NSG create 
resource "azurerm_network_security_group" "Web-NSG" {
  name = "Web-VM-NSG${random_string.my-Rand.id}"
  location = azurerm_resource_group.RG-1.location
  resource_group_name = azurerm_resource_group.RG-1.name
}

locals {
  Web-VM-port={
    100 : "22"
    110 : "443"
    120 : "80"
  }
}
# NSG security rule 
resource "azurerm_network_security_rule" "Web-VM-NSG" {
  for_each = local.Web-VM-port
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
    network_security_group_name = azurerm_network_security_group.Web-NSG.name
}
# NSG associate with nic with different NSG
resource "azurerm_network_interface_security_group_association" "web-VM-nic-with-NSG" {
  depends_on = [ azurerm_network_security_rule.Web-VM-NSG ]
      network_interface_id = azurerm_network_interface.Web-VM-Nic.id
       network_security_group_id = azurerm_network_security_group.Web-NSG.id
} 