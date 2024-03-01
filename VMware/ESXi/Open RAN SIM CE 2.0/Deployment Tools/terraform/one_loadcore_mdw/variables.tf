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
variable "loadcore_mdw_image_path" {
  default = "G:\\terraform_scripts\\backup agents with MW IP\\LoadCore-Agent-3.0.0.640-dd679b121-20211215T114149Z.ova"
  type    = string
  description = "The image path for LoadCore MDW. Make sure to put double \\"
}
variable "management_network" {
  default = "Management Network - External"
  type    = string
  description = "The management network used by both LoadCore and LoadCore Agents"
}
variable "vm_prefix" {
  default = "LoadCore_Agent"
  type    = string
  description = "LoadCore Prefix to be added to VMs name"
}