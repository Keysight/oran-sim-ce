# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

data "azurerm_image" "loadcore_mdw_image" {
  name                = "${var.loadcore_mdw_name}"
  resource_group_name = "${var.images_resource_group_name}"
}

data "azurerm_image" "loadcore_agent_image" {
  name                = "${var.loadcore_agent_name}"
  resource_group_name = "${var.images_resource_group_name}"
  
}

locals {
  agent_mgmt_interface_name = "eth0"
  agent_startup_script = <<-EOF
                #! /bin/bash
                sudo /opt/5gc-test-engine/agent-setup.sh ${azurerm_linux_virtual_machine.loadcore_mdw.private_ip_address} ${local.agent_mgmt_interface_name} "" y
    EOF
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.prefix}-network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["${var.virtual_network_cidr}"]
}

resource "azurerm_subnet" "mgmt_subnet" {
  name                 = "mgmt_subnet"
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["${var.virtual_network_mgmt_subnet}"]
}

resource "azurerm_subnet" "test_subnet" {
  name                 = "test_subnet"
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["${var.virtual_network_test_subnet}"]
}

resource "azurerm_public_ip" "pip" {
  name                = "${var.prefix}-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "loadcore_mdw_mgmt_interface" {
  name                = "${var.prefix}-nic"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.mgmt_subnet.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_network_interface" "loadcore_agent_mgmt_interface" {
  name                = "${var.prefix}-agent-nic1"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.mgmt_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "loadcore_agent_test_interface_1" {
  name                = "${var.prefix}-agent-test-nic1"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
    primary = true
  }
  ip_configuration {
    name                          = "testconfiguration2"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
  ip_configuration {
    name                          = "testconfiguration3"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration4"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration5"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration6"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration7"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration8"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "loadcore_agent_test_interface_2" {
  name                = "${var.prefix}-agent-test-nic2"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
    primary = true
  }
  ip_configuration {
    name                          = "testconfiguration2"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
  ip_configuration {
    name                          = "testconfiguration3"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration4"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration5"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration6"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration7"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration8"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_network_interface" "loadcore_agent2_mgmt_interface" {
  name                = "${var.prefix}-agent2-nic1"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.mgmt_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "loadcore_agent2_test_interface_1" {
  name                = "${var.prefix}-agent2-test-nic1"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
    primary = true
  }
  ip_configuration {
    name                          = "testconfiguration2"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
  ip_configuration {
    name                          = "testconfiguration3"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration4"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration5"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration6"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration7"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration8"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "loadcore_agent2_test_interface_2" {
  name                = "${var.prefix}-agent2-test-nic2"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
    primary = true
  }
  ip_configuration {
    name                          = "testconfiguration2"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
  ip_configuration {
    name                          = "testconfiguration3"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration4"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration5"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration6"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration7"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
    ip_configuration {
    name                          = "testconfiguration8"
    subnet_id                     = "${azurerm_subnet.test_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "loadcore_mdw" {
  name                  = "TF-LoadCore-MDW"
  location              = "${azurerm_resource_group.rg.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  network_interface_ids = ["${azurerm_network_interface.loadcore_mdw_mgmt_interface.id}"]
  size               = "${var.loadcore_mdw_size}"
  


  source_image_id = "${data.azurerm_image.loadcore_mdw_image.id}"
  admin_username      = "loadcore"
  admin_ssh_key {
    username   = "loadcore"
    public_key = data.azurerm_ssh_public_key.ssh_key.public_key
  }
  disable_password_authentication = true
  
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

}


resource "azurerm_linux_virtual_machine" "loadcore_agent1" {
  name                  = "TF-LoadCore-Agent-1"
  location              = "${azurerm_resource_group.rg.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  network_interface_ids = ["${azurerm_network_interface.loadcore_agent_mgmt_interface.id}", 
                        "${azurerm_network_interface.loadcore_agent_test_interface_1.id}",
                        "${azurerm_network_interface.loadcore_agent_test_interface_2.id}"
                        ]
  size               = "${var.loadcore_agents_size}"


  source_image_id = "${data.azurerm_image.loadcore_agent_image.id}"

  admin_username      = "loadcore"
  admin_ssh_key {
    username   = "loadcore"
    public_key = data.azurerm_ssh_public_key.ssh_key.public_key
  }
  disable_password_authentication = true

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  custom_data = base64encode(local.agent_startup_script)
}


resource "azurerm_linux_virtual_machine" "loadcore_agent2" {
  name                  = "TF-LoadCore-Agent-2"
  location              = "${azurerm_resource_group.rg.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  network_interface_ids = ["${azurerm_network_interface.loadcore_agent2_mgmt_interface.id}", 
                        "${azurerm_network_interface.loadcore_agent2_test_interface_1.id}",
                        "${azurerm_network_interface.loadcore_agent2_test_interface_2.id}"
                        ]
  size               = "Standard_F4s"


  source_image_id = "${data.azurerm_image.loadcore_agent_image.id}"

  admin_username      = "loadcore"
  admin_ssh_key {
    username   = "loadcore"
    public_key = data.azurerm_ssh_public_key.ssh_key.public_key
  }
  disable_password_authentication = true

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  custom_data = base64encode(local.agent_startup_script)
}

data "azurerm_ssh_public_key" "ssh_key" {
  name                = "${var.ssh_key_name}"
  resource_group_name = "load-core-mdw-images"
}

resource "azurerm_network_security_group" "sg_mgmt" {
  name                = "${var.prefix}-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "ssh"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.sg_mgmt.name
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "${var.allowed_cidr}"
  destination_address_prefix  = "*"
}

resource "azurerm_network_security_rule" "https" {
  name                        = "https"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.sg_mgmt.name
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "${var.allowed_cidr}"
  destination_address_prefix  = "*"
}

resource "azurerm_network_interface_security_group_association" "sg_association" {
  network_interface_id      = azurerm_network_interface.loadcore_mdw_mgmt_interface.id
  network_security_group_id = azurerm_network_security_group.sg_mgmt.id
}


output "LoadCore_MDW_IP_address" {
  description = "The LoadCore MDW public ip"
  value       = "${azurerm_public_ip.pip.ip_address}"
}

output "Agent1_mgmt_interface" {
  description = "Agent1_mgmt_interface"
  value       = "${azurerm_network_interface.loadcore_agent_mgmt_interface.private_ip_addresses}"
}

output "Agent1_first_test_interface" {
  description = "Agent1_first_test_interface"
  value       = "${azurerm_network_interface.loadcore_agent_test_interface_1.private_ip_addresses}"
}

output "Agent1_second_test_interface" {
  description = "Agent1_first_test_interface"
  value       = "${azurerm_network_interface.loadcore_agent_test_interface_2.private_ip_addresses}"
}

output "Agent2_mgmt_interface" {
  description = "Agent2_mgmt_interface"
  value       = "${azurerm_network_interface.loadcore_agent2_mgmt_interface.private_ip_addresses}"
}

output "Agent2_first_test_interface" {
  description = "Agent2_first_test_interface"
  value       = "${azurerm_network_interface.loadcore_agent2_test_interface_1.private_ip_addresses}"
}

output "Agent2_second_test_interface" {
  description = "Agent2_first_test_interface"
  value       = "${azurerm_network_interface.loadcore_agent2_test_interface_2.private_ip_addresses}"
}

