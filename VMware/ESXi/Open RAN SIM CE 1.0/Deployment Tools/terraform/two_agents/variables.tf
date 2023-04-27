variable "esxi_hostname" {
  default = "esx-croco3.buh.is.keysight.com"
  type    = string
}
variable "esxi_hostport" {
  default = "22"
  type    = string
}
variable "esxi_sslhostport" {
  default = "443"
  type    = string
}
variable "esxi_username" {
  default = "root"
  type    = string
}
variable "esxi_password" {
  default = "password"
  type    = string
}
variable "esxi_datastore" {
  default = "datastore1"
  type    = string
}
variable "loadcore_agent_image_path" {
  default = "G:\\terraform_scripts\\backup agents with MW IP\\LoadCore-Agent-3.0.0.640-dd679b121-20211215T114149Z.ova"
  type    = string
  description = "The image path for LoadCore Agents. Make sure to put double \\"
}
variable "management_network" {
  default = "Management Network - External"
  type    = string
  description = "The management network used by both LoadCore and LoadCore Agents"
}
variable "test_network" {
  default = "Test Network"
  type    = string
  description = "The test network LoadCore Agents"
}
variable "agent_username" {
  default = "ixia"
  type    = string
}
variable "agent_password" {
  default = "ixia"
  type    = string
}

variable "loadcore_mdw_ip" {
  default = "ixia"
  type    = string
  description = "LoadCore IP address which will be used to connect the Agents"
}

variable "loadcore_agent_management_interface_name" {
  default = "ens32"
  type    = string
  description = "LoadCore Agent management interface name"
}

variable "vm_prefix" {
  default = "LoadCore_Agent"
  type    = string
  description = "LoadCore Prefix to be added to VMs name"
}

variable "ram" {
  default = 4096
  type    = number
  description = "Amount of RAM"
}

variable "vcpus" {
  default = 4
  type    = number
  description = "Number of vcpus"
}