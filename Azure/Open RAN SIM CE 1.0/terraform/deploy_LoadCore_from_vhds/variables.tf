variable "prefix" {
  type = string
  description = "Stack name"
}

variable "location" {
  type = string
}

variable "loadcore_mdw_blob_uri" {
  description = "The blob uri of the Custom Image."
}

variable "loadcore_agent_blob_uri" {
  description = "The blob uri of the Custom Image."
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

