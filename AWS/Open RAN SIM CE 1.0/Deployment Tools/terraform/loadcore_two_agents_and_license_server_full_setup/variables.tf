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

variable "allowed_cidr"{
  type = list(string)
  default = ["0.0.0.0/0"]
  description = "List of ips allowed to access the instances"
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

variable "vpc_cidr"{
  type = string
  default = "20.0.0.0/16"
  description = "The VPC cidr"
}

variable "mgmt_subnet"{
  type = string
  default = "20.0.0.0/24"
  description = "The Management subnet"
}

variable "test_subnet"{
  type = string
  default = "20.0.1.0/24"
  description = "The test subnet for the traffic between Agents"
}

variable "agent1_test_private_IPs"{
  type = list(string)
  description = "List of private ips assigned to agent1 test interface"
}

variable "agent2_test_private_IPs"{
  type = list(string)
  description = "List of private ips assigned to agent2 test interface"
}
