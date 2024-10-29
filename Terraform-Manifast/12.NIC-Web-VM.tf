# this NIC for web-linux-VM  by web-subnet  
resource "azurerm_network_interface" "Web-VM-Nic" {
  name = "web-nic-VM${random_string.my-Rand.id}"
  resource_group_name = azurerm_resource_group.RG-1.name
  location = azurerm_resource_group.RG-1.location
  ip_configuration {
    name = "linuxVM-pub1"
    subnet_id = azurerm_subnet.Web-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.linux-VM-public_ip.id
  }
}
