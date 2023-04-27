terraform {
  required_version = ">= 0.13"
  required_providers {
    esxi = {
      source = "registry.terraform.io/josenk/esxi"
    }
  }
}

provider "esxi" {
  esxi_hostname = var.esxi_hostname
  esxi_hostport = var.esxi_hostport
  esxi_hostssl = var.esxi_sslhostport  
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

resource "esxi_guest" "loadcore_mdw" {
  guest_name         = "${var.vm_prefix}-MDW"
  disk_store         = var.esxi_datastore
  ovf_source         = var.loadcore_mdw_image_path

  network_interfaces {
    virtual_network = var.management_network
  }
}

output "LoadCore_MDW_IP" {
  value = esxi_guest.loadcore_mdw.ip_address
}
