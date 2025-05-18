provider "azurerm" {
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "tfstate7342"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    access_key           = "changeme"
  }
}
module "resource_group" {
  source               = "../../modules/resource_group"
  resource_group       = "${var.resource_group}"
  location             = "${var.location}"
}
module "network" {
  source               = "../../modules/network"
  address_space        = "${var.address_space}"
  location             = "${var.location}"
  virtual_network_name = "${var.virtual_network_name}"
  application_type     = "${var.application_type}"
  resource_type        = "NET"
  resource_group       = "${module.resource_group.resource_group_name}"
  address_prefix_test  = "${var.address_prefix_test}"
}

module "nsg-test" {
  source           = "../../modules/networksecuritygroup"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "NSG"
  resource_group   = "${module.resource_group.resource_group_name}"
  subnet_id        = "${module.network.subnet_id_test}"
  address_prefix_test = "${var.address_prefix_test}"
}
module "appservice" {
  source           = "../../modules/appservice"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "AppService"
  resource_group   = "${module.resource_group.resource_group_name}"
}
module "publicip" {
  source           = "../../modules/publicip"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "publicip"
  resource_group   = "${module.resource_group.resource_group_name}"
}
/*module "vm" {
  source               = "../../modules/vm"
  address_space        = "${var.address_space}"
  resource_group       = "${var.resource_group}"
  location             = "${var.location}"
  virtual_network_name = "${var.virtual_network_name}"
  address_prefix_test  = "${var.address_prefix_test}"
  application_type     = "${var.application_type}"
  subnet_id            = "${module.network.subnet_id_test}"
  public_ip            = "${module.publicip.public_ip_address_id}"
  network_interface_id = azurerm_network_interface.udacity-final-nic.id
}
resource "azurerm_network_interface" "udacity-final-nic" {
  name                = "udacity-final-nic"
  location            = "${var.location}"
  #resource_group_name = azurerm_resource_group.main.name
  resource_group       = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
  }
}
*/