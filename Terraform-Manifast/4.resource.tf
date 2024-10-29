resource "random_string" "my-Rand" {
  length = 6
  upper = false
  special = false
}
#create resource group
resource "azurerm_resource_group" "RG-1" {
  name = "${local.resource_name_prefix}-${var.school_collage}-${random_string.my-Rand.id}"
  location = "${var.path}"
  tags = local.gujjar_tag
}