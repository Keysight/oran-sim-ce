variable "prefix" {
  type = string
  description = "Stack name"
}

variable "location" {
  type = string
}

variable "images_resource_group_name" {
  description = "The name of the Resource Group in which the Custom Image exists."
}

variable "loadcore_mdw_name" {
  description = "The name of the Custom Image to provision this Virtual Machine from."
}

variable "loadcore_agent_name" {
  description = "The name of the Custom Image to provision this Virtual Machine from."
}

variable "ssh_key_name" {
  description = "Ssh key name"
}

variable "allowed_cidr" {
  description = "IP address"
}

variable "loadcore_mdw_size" {
  description = "LoadCore MDW size"
  default = "Standard_D8s_v3"
}

variable "loadcore_agents_size" {
  description = "LoadCore MDW size"
  default = "Standard_F4s"
}

variable "virtual_network_cidr" {
  description = "virtual_network_cidr"
  default = "10.0.0.0/16"
}

variable "virtual_network_mgmt_subnet" {
  description = "virtual_network_mgmt_subnet"
  default = "10.0.0.0/24"
}

variable "virtual_network_test_subnet" {
  description = "virtual_network_test_subnet"
  default = "10.0.1.0/24"
}

