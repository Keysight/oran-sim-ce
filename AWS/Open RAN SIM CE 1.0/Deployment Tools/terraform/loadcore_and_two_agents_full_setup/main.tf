provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token = "IQoJb3JpZ2luX2VjEE8aCXVzLWVhc3QtMSJHMEUCIQD9+ZmBcHRCz1h0ERLrRjHMVQvKu+UiCvObk7pXw/Z0kQIgNf0wkG+I8P5HNvDIHWJcMLNNv3NcLYSMS2cF5pKUEKQq8QMIeBADGgw2NzI3Nzk4Njg3NjciDN85dCPu/O/a2JyikirOA1lFbX+Dh8k7mfNdcCCYixkdb7F0YhThvreZ9F56TgBQW+39lIz+WtlAz/6WCWdcuHwQkd9JpSxVdGnEENUqX/zBXUsBTulVDny6o4DVYoI1UlIE46d9pt7uSNva8+lZ2IP75EeL1txAjSz68fO9sOdGa/uPwEIEVjitWSPA7WL6Qps8bAnbEdKYYgb5RLfwF5hDCrMdyjBw/SQ/3N9W3nLQtc7wqqHp3CFL/hcag4/m+rKO0WB4ej6PjyNGRQQYburI1fJE9ejqxirJI66339OAIdKucobZCkmAZWVt9KOdgC+k5MssIr6tc6VNivoB771dBQh0xZ12xvbJHy5f0AHh3IG9kkiMYrNnZiSgDNTvkapZjcuZAqDZqjGp2qN/JD+B7F8bgTnNVnWBo+r1wXYVuFKRiR+/CgWLqcXNMcrFlL9jveGSDDWzIxi5NNxpwPSREp3NREtjf/5PHMbScr7v89hKJjA17UXiE47Qshy7Tb7pYMSKtpEloAJ06HdL/wIlrGu7B5KMi8eku7LGV44qMA7fDNASS9HSzD7RjYl1QbHFM7/kjR+JYEjWgHLLP9Rv3TlAr4gLp0sKK+U5YtGQN4roAt2Y0FTBcQMaiDC4lJ6jBjqmARNCqRmWGYxbYNMgzfemrdb5TsecW0UrgsKDLKVNSIyfEa/TdRTiTtkPmQPInxW6tYUfZ7dESnAyaP+1bP+ygxXWqnox6csNVg8xbW0rLWjltebsburAknmjN5LSjLXpBL/O6RuRJh94Jmafz7I45/uKmo+o99+bpn2BGovA56O0taWc5cbuwBCbhRQqqkjnitgN02ux0ovqCjEeEl/rWoFVMCFUuDI="
  region = var.region
}

locals{
    vpc_cidr = var.vpc_cidr
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
    inbound_cidr_rule = concat(var.allowed_cidr,[local.mgmt_subnet],[local.test_subnet])
}

resource "aws_vpc" "aws_main_vpc" {
    tags = {
        Name = "${var.stack_name}-main-vpc"
    }
    enable_dns_hostnames = true
    enable_dns_support = true
    cidr_block = local.vpc_cidr
}

resource "aws_subnet" "aws_management_subnet" {
    vpc_id     = aws_vpc.aws_main_vpc.id
    cidr_block = local.mgmt_subnet
    availability_zone = var.availability_zone
    tags = {
        Name = "${var.stack_name}-management-subnet"
    }
}

resource "aws_subnet" "aws_test_subnet" {
    vpc_id     = aws_vpc.aws_main_vpc.id
    availability_zone = var.availability_zone
    cidr_block = local.test_subnet
    tags = {
        Name = "${var.stack_name}-test-subnet"
    }
}

resource "aws_security_group" "aws_test_security_group" {
    name = "test-security-group"
    tags = {
        Name = "${var.stack_name}-test-security-group"
    }
    description = "Test security group"
    vpc_id = aws_vpc.aws_main_vpc.id
}

resource "aws_security_group" "aws_mgmt_security_group" {
    name = "mdw-security-group"
    tags = {
        Name = "${var.stack_name}-mgmt-security-group"
    }
    description = "Mgmt security group"
    vpc_id = aws_vpc.aws_main_vpc.id
}

resource "aws_security_group_rule" "aws_mgmt_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = local.inbound_cidr_rule
  ipv6_cidr_blocks  = ["::/128"]
  security_group_id = aws_security_group.aws_mgmt_security_group.id
}

resource "aws_security_group_rule" "aws_mgmt_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.aws_mgmt_security_group.id
}

resource "aws_security_group_rule" "aws_test_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = local.inbound_cidr_rule
  ipv6_cidr_blocks  = ["::/128"]
  security_group_id = aws_security_group.aws_test_security_group.id
}

resource "aws_security_group_rule" "aws_test_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.aws_test_security_group.id
}

resource "aws_vpc_dhcp_options" "aws_main_vpc_dhcp_options" {
    tags = {
        Name = "${var.stack_name}-dhcp-option"
    }
    domain_name_servers  = ["8.8.8.8",
                            "8.8.4.4",
                            "AmazonProvidedDNS" ]
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
    vpc_id          = aws_vpc.aws_main_vpc.id
    dhcp_options_id = aws_vpc_dhcp_options.aws_main_vpc_dhcp_options.id
}

resource "aws_route_table" "aws_private_rt" {
    vpc_id = aws_vpc.aws_main_vpc.id
    tags = {
        Name = "${var.stack_name}-private-rt"
    }    
}

resource "aws_route_table_association" "aws_test_rt_association" {
    subnet_id      = aws_subnet.aws_test_subnet.id
    route_table_id = aws_route_table.aws_private_rt.id
}

resource "aws_route_table" "aws_public_rt" {
    vpc_id = aws_vpc.aws_main_vpc.id
    tags = {
        Name = "${var.stack_name}-public-rt"
    }        
}

resource "aws_route_table_association" "aws_mgmt_rt_association" {
    subnet_id      = aws_subnet.aws_management_subnet.id
    route_table_id = aws_route_table.aws_public_rt.id
}

resource "aws_internet_gateway" "aws_internet_gateway" {
    tags = {
        Name = "${var.stack_name}-internet-gateway"
    }
    vpc_id = aws_vpc.aws_main_vpc.id  
}

resource "aws_route" "aws_route_to_internet" {
    depends_on = [
      aws_route_table_association.aws_mgmt_rt_association
    ]
    route_table_id            = aws_route_table.aws_public_rt.id
    destination_cidr_block    = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_internet_gateway.id
}

resource "aws_network_interface" "aws_loadcore_interface" {
    tags = {
        Name = "${var.stack_name}-mdw-mgmt-interface"
    }
    source_dest_check = true
    subnet_id = aws_subnet.aws_management_subnet.id
    security_groups = [ aws_security_group.aws_mgmt_security_group.id ]
}

resource "aws_network_interface" "aws_agent1_mgmt_interface" {
    tags = {
        Name = "${var.stack_name}-agent1-mgmt-interface"
    }
    security_groups = [ aws_security_group.aws_mgmt_security_group.id ]
    source_dest_check = true
    subnet_id = aws_subnet.aws_management_subnet.id
}

resource "aws_network_interface" "aws_agent2_mgmt_interface" {
    tags = {
        Name = "${var.stack_name}-agent2-mgmt-interface"
    }
    security_groups = [ aws_security_group.aws_mgmt_security_group.id ]
    source_dest_check = true
    subnet_id = aws_subnet.aws_management_subnet.id
}

resource "aws_network_interface" "aws_agent1_test_interface" {
    tags = {
        Name = "${var.stack_name}-agent1-test-interface"
    }
    private_ips = var.agent1_test_private_IPs
    source_dest_check = false
    subnet_id = aws_subnet.aws_test_subnet.id
    security_groups = [ aws_security_group.aws_test_security_group.id ]
}

resource "aws_network_interface" "aws_agent1_test2_interface" {
    tags = {
        Name = "${var.stack_name}-agent1-test2-interface"
    }
    private_ips = var.agent1_test2_private_IPs
    source_dest_check = false
    subnet_id = aws_subnet.aws_test_subnet.id
    security_groups = [ aws_security_group.aws_test_security_group.id ]
}
resource "aws_network_interface" "aws_agent2_test_interface" {
    tags = {
        Name = "${var.stack_name}-agent2-test-interface"
    }
    private_ips = var.agent2_test_private_IPs
    source_dest_check = false
    subnet_id = aws_subnet.aws_test_subnet.id
    security_groups = [ aws_security_group.aws_test_security_group.id ]
}

resource "aws_network_interface" "aws_agent2_test2_interface" {
    tags = {
        Name = "${var.stack_name}-agent2-test2-interface"
    }
    private_ips = var.agent2_test2_private_IPs
    source_dest_check = false
    subnet_id = aws_subnet.aws_test_subnet.id
    security_groups = [ aws_security_group.aws_test_security_group.id ]
}

resource "aws_eip" "loadcore_public_ip" {
  instance = aws_instance.aws_loadcore.id
  vpc = true
  associate_with_private_ip = aws_instance.aws_loadcore.private_ip
  depends_on = [
    aws_internet_gateway.aws_internet_gateway
  ]
}

data "aws_ami" "loadcore_ami" {
    owners = ["self"]
    most_recent = true
    filter {
      name   = "name"
      values = [var.loadcore_version]
    }
}

data "aws_ami" "agent_ami" {
    owners = ["self"]
    most_recent = true
    filter {
      name   = "name"
      values = [var.loadcore_agent_version]
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

    network_interface {
        network_interface_id = aws_network_interface.aws_agent1_test2_interface.id
        device_index         = 2
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

    network_interface {
        network_interface_id = aws_network_interface.aws_agent2_test2_interface.id
        device_index         = 2
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

output "LoadcoreAgent1-private1" {
  value = {
    "LoadCore Agent1 eth1 Private IP"  : aws_network_interface.aws_agent1_test_interface.private_ips
  }
}

output "LoadcoreAgent1-private2" {
  value = {
    "LoadCore Agent1 eth2 Private IP"  : aws_network_interface.aws_agent1_test2_interface.private_ips
  }
}

output "LoadcoreAgent2" {
  value = {
    "Name": local.agent2_name,
    "LoadCore Agent1 Private IP"  : aws_instance.aws_agent2.private_ip
  }
}

output "LoadcoreAgent2-private1" {
  value = {
    "LoadCore Agent2 eth1 Private IP"  : aws_network_interface.aws_agent2_test_interface.private_ips
  }
}

output "LoadcoreAgent2-private2" {
  value = {
    "LoadCore Agent2 eth2 Private IP"  : aws_network_interface.aws_agent2_test2_interface.private_ips
  }
}
