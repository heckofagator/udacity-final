resource "azurerm_network_interface" "" {
  name                = ""
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = ""
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = ""
  }
}

resource "azurerm_linux_virtual_machine" "" {
  name                = "Udacity-Final-vm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  size                = "Standard_DS2_v2"
  admin_username      = ""
  network_interface_ids = []
  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2Pn+dZER8DR4U7HZB6WLHlixEPuRiBeCNbv0T23s2Jmur4NKJt/E27hio642TCJNNIXcI7RoXo+CcCJbI8X+O4s4picX2mvdxT7DBAJh3qF01cQ4RnVK/DEqi85E+4y+1FH73wG10+WdaRrJZcWD4NC8tx3XuUVQ3eS7FZjXWW4zKXkXN9auzJagpl+rQWzp+Hq0P3ENVSww6az1YzNYfqSs/n4v/ZAzXrws8lShI5uP6HGkw29Pr+tGYZN6hDRJiSr/grlk9p7N2eCE+EFDL6VOXW1C+0xerFTX+2yq3wVtBjAtNb5IjXwtBB+rZOkx7cnXM1Kmwsa+jFI2+moGhAbrxRBBbHUegGbSJBJzNq58naMD1aMLyweZpmB++Kq5xZVGBAdjqCxnnyqdoChs11meW3VImTDkYziWF9+Lx37WSFT63rOXrOC2S/S7cH2ApQKnD3gSMupa4ick7EWqghxMNWQ0oYdet9l7gnPvme5rdmVqJyWmJCHd00aFqvJM= aaron@Aaron-Home-PC"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
