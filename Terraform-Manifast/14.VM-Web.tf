resource "azurerm_linux_virtual_machine" "web-linux-virtual_machine" {
  name = "${local.resource_name_prefix}-${random_string.my-Rand.id}-web-linuxVM"
  location = azurerm_resource_group.RG-1.location
  resource_group_name = azurerm_resource_group.RG-1.name
  size= "Standard_DS1_v2"
  admin_username = "ruby-adhana"
  network_interface_ids = [azurerm_network_interface.Web-VM-Nic.id]
  admin_ssh_key {
    username = "ruby-adhana"
    public_key = file(".ssh/ruby-key.pub")
    # public_key = file("${path.module}/.ssh/ruby-key.pub")         # if .ssh file inside where terraform init
    # public_key = file("C:/Users/rubya/.ssh/ruby-key.pub")         # other location OR
    # public_key = file("~/.ssh/ruby-key.pub")                      # last same location only shortcut   
    
  }
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
source_image_reference {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "18.04-LTS"
  version   = "latest"
}

# custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh")
custom_data = base64encode(local.a) 

}

locals {
a = <<CUSTOM_DATA
#!/bin/sh
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2 
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to stacksimplify - WebVM App1 - VM Hostname: (hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/app1
CUSTOM_DATA
}