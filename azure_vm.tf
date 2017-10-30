/* This terraform configuration creates VM on azure & Deploy Jenkins on it */

resource "azurerm_virtual_machine" "jenkins" {
  name                  = "${var.vm_name}"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"
  network_interface_ids = ["${azurerm_network_interface.public_nic.id}"]
  vm_size               = "${var.vm_size}"

  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name          = "jenkins-osdisk"
    vhd_uri       = "${azurerm_storage_account.jenkins_storage.primary_blob_endpoint}${azurerm_storage_container.jenkins_cont.name}/osdisk-1.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "${var.os_name}"
    admin_username = "${var.vm_username}"
    admin_password = "${var.vm_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}


resource "azurerm_virtual_machine_extension" "jenkins_terraform" {
  name                 = "jenkins_extension"
  location             = "${var.location}"
  resource_group_name  = "${azurerm_resource_group.terraform_rg.name}"
  virtual_machine_name = "${azurerm_virtual_machine.jenkins.name}"
  publisher            = "Microsoft.OSTCExtensions"
  type                 = "CustomScriptForLinux"
  type_handler_version = "1.2"

  settings = <<SETTINGS
  {
          "fileUris": ["https://raw.githubusercontent.com/xenonstack/terraform-jenkins-azure/master/jenkins-init.sh"],
          "commandToExecute": "sh jenkins-init.sh"
      }
SETTINGS
}

terraform {
  backend "azurerm" {
    storage_account_name = ""
    container_name       = ""
    key                  = "terraform.tfstate"
    access_key           = ""

  }
}
