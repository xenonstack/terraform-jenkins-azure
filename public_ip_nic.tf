/* This terraform configuration connects NIC to our resource group & Jenkins VM & provide public IP to it */

resource "azurerm_public_ip" "jenkins_pip" {
  name 				= "Jenkins_Public_IP"
  location 			= "${var.location}"
  resource_group_name 		= "${azurerm_resource_group.terraform_rg.name}"
  public_ip_address_allocation 	= "static"
}

resource "azurerm_network_interface" "public_nic" {
  name 		      = "Jenkins_Public_NIC"
  location 	      = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform_rg.name}"
  network_security_group_id = "${azurerm_network_security_group.jenkins_security.id}"

  ip_configuration {
    name 			= "jenkins-Private"
    subnet_id 			= "${azurerm_subnet.jenkins_subnet.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id	= "${azurerm_public_ip.jenkins_pip.id}"
  }
}
