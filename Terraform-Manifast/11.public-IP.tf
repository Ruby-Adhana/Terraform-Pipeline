resource "azurerm_public_ip" "linux-VM-public_ip" {
  name = "${local.resource_name_prefix}-Web-linux-Pub_IP"
  location = azurerm_resource_group.RG-1.location
  resource_group_name = azurerm_resource_group.RG-1.name
  allocation_method = "Static"
  sku = "Standard"
  domain_name_label = "ruby-adhana-${random_string.my-Rand.id}"
}
