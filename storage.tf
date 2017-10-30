/* This terraform configuration creates storage account on Azure & creates a container for storing virtual machine HD image */

resource "azurerm_storage_account" "jenkins_storage" {
  name 			= "${var.storage_account_name}"
  resource_group_name 	= "${azurerm_resource_group.terraform_rg.name}"
  location 		= "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "jenkins_cont" {
  name 			= "${var.container_name}"
  resource_group_name 	= "${azurerm_resource_group.terraform_rg.name}"
  storage_account_name 	= "${azurerm_storage_account.jenkins_storage.name}"
  container_access_type = "private"
}
