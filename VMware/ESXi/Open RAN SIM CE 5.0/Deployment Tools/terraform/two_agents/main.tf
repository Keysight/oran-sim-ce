terraform {
  required_version = ">= 0.13"
  required_providers {
    esxi = {
      source = "registry.terraform.io/josenk/esxi"
    }
  }
}

locals {
  loadcore_mdw_ip = var.loadcore_mdw_ip
  vm_prefix = var.vm_prefix
  loadcore_agent_management_interface_name = var.loadcore_agent_management_interface_name
}

provider "esxi" {
  esxi_hostname = var.esxi_hostname
  esxi_hostport = var.esxi_hostport
  esxi_hostssl = var.esxi_sslhostport  
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

resource "esxi_guest" "esxi_agent1" {
  guest_name         = "${local.vm_prefix}-Agent1"
  disk_store         = var.esxi_datastore
  ovf_source         = var.loadcore_agent_image_path
  numvcpus           = var.vcpus
  memsize            = var.ram

  network_interfaces {
    virtual_network = var.management_network
  }
  network_interfaces {
    virtual_network = var.test_network
	nic_type        = "vmxnet3"
  }

  network_interfaces {
    virtual_network = var.test_network
	nic_type        = "vmxnet3"
  }

  
  provisioner "remote-exec" {
   connection {
     user = var.agent_username
     password = var.agent_password
     host = self.ip_address
   }
   inline = [
     "echo 'ixia' | sudo -S ./agent-setup.sh ${local.loadcore_mdw_ip} ${local.loadcore_agent_management_interface_name} '' y"
     ]
}
}

resource "esxi_guest" "esxi_agent2" {
  guest_name         = "${local.vm_prefix}-Agent2"
  disk_store         = var.esxi_datastore
  ovf_source         = var.loadcore_agent_image_path
  numvcpus           = var.vcpus
  memsize            = var.ram


  network_interfaces {
    virtual_network = var.management_network
  }
  network_interfaces {
    virtual_network = var.test_network
	nic_type        = "vmxnet3"
  }

  provisioner "remote-exec" {
   connection {
     user = var.agent_username
     password = var.agent_password
     host = self.ip_address
   }
   inline = [
     "echo 'ixia' | sudo -S ./agent-setup.sh ${local.loadcore_mdw_ip} ${local.loadcore_agent_management_interface_name} '' y"
     ]
}
}

output "loadcore_mdw_ip" {
  value = local.loadcore_mdw_ip
}

output "agent1_ip" {
  value = esxi_guest.esxi_agent1.ip_address
}

output "agent2_ip" {
  value = esxi_guest.esxi_agent2.ip_address
}
