variable "aws_access_key" {
  type = string
  description = "AWS access key"
}

variable "aws_secret_key" {
  type = string
  description = "AWS secret key"
}

variable "stack_name" {
  type = string
  description = "Stack name"
}

variable "ssh_key" {
  type = string
  description = "The key used to ssh into VMs"
}

variable "region" {
  type    = string
  description = "AWS region to be deployed"
  default = "us-east-2"
}

variable "availability_zone" {
  type    = string
  description = "AWS availability zone"
  default = "us-east-2a"
}

variable "loadcore_type"{
  type = string
  default = "c4.2xlarge"
  description = "LoadCore instance type"
}

variable "loadcore_agent_type" {
  type = string
  default = "c5.2xlarge"
  description = "LoadCore Agent instance type"
}

variable "loadcore_license_server_type" {
  type = string
  default = "t2.medium"
  description = "LoadCore License Server instance type"
}

variable "loadcore_version" {
  type        = string
  default     = "LoadCore-MDW-4.2.0-3747-298-*-*"
  description = "Image name for LoadCore"
}

variable "loadcore_agent_version" {
  type        = string
  default     = "LoadCore-Agent-4.2.0.5-*"
  description = "Image name for LoadCore Agent"
}

variable "loadcore_license_server_version" {
  type        = string
  default     = " LoadCore-Licensing-4.2.0-208*"
  description = "Image name for LoadCore License Server"
}

variable "mgmt_subnet"{
  type = string
  default = "subnet-0a87408455ab56c3e"
  description = "The Management subnet"
}

variable "test_subnet"{
  type = string
  default = "subnet-0a87408455ab56c3e"
  description = "The test subnet for the traffic between Agents"
}

variable mgmt_security_group {
    type = string
    default ="sg-0d70d3f602bcec4a0"
    description = "The security_group for the management traffic"
}

variable test_security_group {
    type = string
    default ="sg-0d70d3f602bcec4a0"
    description = "The security_group for the test traffic"
}

variable "no_of_private_ips_agents"{
  type = number
  description = "Number of private ips assigned to agent1 test interface"
}
