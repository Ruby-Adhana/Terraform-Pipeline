resource "azurerm_virtual_network" "My-Vnet" {
    name = "aachal-${local.resource_name_prefix}-${random_string.my-Rand.id}"
    location = azurerm_resource_group.RG-1.location
    resource_group_name = azurerm_resource_group.RG-1.name
    address_space = var.virtual_net-ip-addr 
}