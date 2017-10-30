/* This terraform configuration creates Resource Group , Network & it's subnet */

resource "azurerm_resource_group" "terraform_rg" {
  name 		= "${var.resource_group_name}"
  location 	= "${var.location}"
}

resource "azurerm_virtual_network" "jenkins_vnet" {
  name 			= "${var.network_name}"
  address_space 	= ["${var.vnet_cidr}"]
  location 		= "${var.location}"
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"
}

resource "azurerm_subnet" "jenkins_subnet" {
  name 			= "${var.subnet_name}"
  address_prefix 	= "${var.subnet_cidr}"
  virtual_network_name 	= "${azurerm_virtual_network.jenkins_vnet.name}"
  resource_group_name 	= "${azurerm_resource_group.terraform_rg.name}"
}
