provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = var.region
}

locals{
    mgmt_subnet = var.mgmt_subnet
    test_subnet = var.test_subnet
    loadcore_name = "${var.stack_name}-MW"
    agent1_name = "${var.stack_name}-Agent1"
    agent2_name = "${var.stack_name}-Agent2"
    license_server_name = "${var.stack_name}-LicenseServer"
    agent_mgmt_interface_name = "eth0"
	agent_test_interface_name = "eth1"
    agent_startup_script = <<-EOF
                #! /bin/bash
                sudo /opt/5gc-test-engine/agent-setup.sh ${aws_instance.aws_loadcore.private_ip} ${local.agent_mgmt_interface_name} "" y
    EOF
}

resource "aws_network_interface" "aws_loadcore_interface" {
    tags = {
        Name = "${var.stack_name}-mdw-mgmt-interface"
    }
    source_dest_check = true
    subnet_id = var.mgmt_subnet
    security_groups = [var.mgmt_security_group]
}

resource "aws_network_interface" "aws_agent1_mgmt_interface" {
    tags = {
        Name = "${var.stack_name}-agent1-mgmt-interface"
    }
    source_dest_check = true
    subnet_id = var.mgmt_subnet
    security_groups = [var.mgmt_security_group]
}

resource "aws_network_interface" "aws_agent2_mgmt_interface" {
    tags = {
        Name = "${var.stack_name}-agent2-mgmt-interface"
    }
    source_dest_check = true
    subnet_id = var.mgmt_subnet
    security_groups = [var.mgmt_security_group]
}

resource "aws_network_interface" "aws_license_server_mgmt_interface" {
    tags = {
        Name = "${var.stack_name}-license_server-mgmt-interface"
    }
    source_dest_check = true
    subnet_id = var.mgmt_subnet
    security_groups = [var.mgmt_security_group]
}

resource "aws_network_interface" "aws_agent1_test_interface" {
    tags = {
        Name = "${var.stack_name}-agent1-test-interface"
    }
    private_ips_count = var.no_of_private_ips_agents
    source_dest_check = false
    subnet_id = var.test_subnet
    security_groups = [var.test_security_group]
}

resource "aws_network_interface" "aws_agent2_test_interface" {
    tags = {
        Name = "${var.stack_name}-agent2-test-interface"
    }
    private_ips_count = var.no_of_private_ips_agents
    source_dest_check = false
    subnet_id = var.test_subnet
    security_groups = [var.test_security_group]
}

resource "aws_eip" "loadcore_public_ip" {
  instance = aws_instance.aws_loadcore.id
  vpc = true
  associate_with_private_ip = aws_instance.aws_loadcore.private_ip
}

resource "aws_eip" "loadcore_license_server_public_ip" {
  instance = aws_instance.aws_license_server.id
  vpc = true
  associate_with_private_ip = aws_instance.aws_license_server.private_ip
}

data "aws_ami" "loadcore_ami" {
    owners = ["aws-marketplace"]
    most_recent = true
    filter {
      name   = "name"
      values = [var.loadcore_version]
    }
}

data "aws_ami" "agent_ami" {
    owners = ["aws-marketplace"]
    most_recent = true
    filter {
      name   = "name"
      values = [var.loadcore_agent_version]
    }
}

data "aws_ami" "license_server_ami" {
    owners = ["aws-marketplace"]
    most_recent = true
    filter {
      name   = "name"
      values = [var.loadcore_license_server_version]
    }
}

resource "aws_instance" "aws_loadcore" {
    tags = {
        Name = local.loadcore_name
    }


    ami           = data.aws_ami.loadcore_ami.image_id 
    instance_type = var.loadcore_type

    ebs_block_device {
        device_name = "/dev/sda1"
        delete_on_termination = true
    }

    network_interface {
        network_interface_id = aws_network_interface.aws_loadcore_interface.id
        device_index         = 0
    }

    credit_specification {
        cpu_credits = "unlimited"
    }

    key_name = var.ssh_key
}

resource "aws_instance" "aws_agent1" {
    tags = {
        Name = local.agent1_name
    }
    ami           = data.aws_ami.agent_ami.image_id 
    instance_type = var.loadcore_agent_type

    ebs_block_device {
        device_name = "/dev/sda1"
        delete_on_termination = true
    }

    network_interface {
        network_interface_id = aws_network_interface.aws_agent1_mgmt_interface.id
        device_index         = 0
    }

    network_interface {
        network_interface_id = aws_network_interface.aws_agent1_test_interface.id
        device_index         = 1
    }
    
    credit_specification {
        cpu_credits = "unlimited"
    }
    user_data = local.agent_startup_script

    key_name = var.ssh_key
}

resource "aws_instance" "aws_agent2" {
    tags = {
        Name = local.agent2_name
    }
    ami           = data.aws_ami.agent_ami.image_id 
    instance_type = var.loadcore_agent_type

    ebs_block_device {
        device_name = "/dev/sda1"
        delete_on_termination = true
    }

    network_interface {
        network_interface_id = aws_network_interface.aws_agent2_mgmt_interface.id
        device_index         = 0
    }

    network_interface {
        network_interface_id = aws_network_interface.aws_agent2_test_interface.id
        device_index         = 1
    }
    
    credit_specification {
        cpu_credits = "unlimited"
    }
    user_data = local.agent_startup_script

    key_name = var.ssh_key
}

resource "aws_instance" "aws_license_server" {
    tags = {
        Name = local.license_server_name
    }
    ami           = data.aws_ami.license_server_ami.image_id 
    instance_type = var.loadcore_license_server_type

    ebs_block_device {
        device_name = "/dev/sda1"
        delete_on_termination = true
    }

    network_interface {
        network_interface_id = aws_network_interface.aws_license_server_mgmt_interface.id
        device_index         = 0
    }
    
    credit_specification {
        cpu_credits = "unlimited"
    }
    user_data = local.agent_startup_script

    key_name = var.ssh_key

}

output "Loadcore" {
  value = {
    "Name": local.loadcore_name,
    "LoadCore UI IP"  : aws_eip.loadcore_public_ip.public_ip
  }
}

output "LoadcoreAgent1" {
  value = {
    "Name": local.agent1_name,
    "LoadCore Agent1 Private IP"  : aws_instance.aws_agent1.private_ip
  }
}

output "LoadcoreAgent2" {
  value = {
    "Name": local.agent2_name,
    "LoadCore Agent1 Private IP"  : aws_instance.aws_agent2.private_ip
  }
}

output "LoadcoreLicenseServer" {
  value = {
    "Name": local.license_server_name,
    "LoadCore License Server UI IP"  : aws_eip.loadcore_license_server_public_ip.public_ip,
    "LoadCore License Server Private IP"  : aws_eip.loadcore_license_server_public_ip.private_ip
  }
}