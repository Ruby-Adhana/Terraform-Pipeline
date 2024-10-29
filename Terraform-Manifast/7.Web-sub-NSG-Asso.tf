resource "azurerm_subnet" "Web-subnet" {
  name = "${var.virtual-net}-${var.web_sub_name}-${random_string.my-Rand.id}"
  resource_group_name = azurerm_resource_group.RG-1.name
  virtual_network_name = azurerm_virtual_network.My-Vnet.name
  address_prefixes = var.web_subnet-ip-addr
}

# create NSG 
resource "azurerm_network_security_group" "my-web-NSG" {
   name = "${var.web_sub_name}-NSG"
   location = azurerm_resource_group.RG-1.location
   resource_group_name = azurerm_resource_group.RG-1.name
}
# if Security-rule define seperatly
#port no define
locals {
  web-port = {
    100 : "80"
    110 : "443"
    120 : "22"
  }
}
resource "azurerm_network_security_rule" "nsg-rule-web" {
    for_each = local.web-port
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
    network_security_group_name = azurerm_network_security_group.my-web-NSG.name
}

# NSG Associate with Web_subnet
resource "azurerm_subnet_network_security_group_association" "Web_subnet-with-NSG" {
  depends_on = [ azurerm_network_security_rule.nsg-rule-web ]
  subnet_id = azurerm_subnet.Web-subnet.id
  network_security_group_id = azurerm_network_security_group.my-web-NSG.id
}