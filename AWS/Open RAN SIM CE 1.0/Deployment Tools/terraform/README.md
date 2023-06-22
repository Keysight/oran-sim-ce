# Terraform templates

## Prerequisites
The prerequisites are:
- Latest version of Terraform installed. https://learn.hashicorp.com/tutorials/terraform/install-cli
- AWS Credentials: AWS Access Key and AWS Secret Key

## How to use:

You can start learning terraform from the official website: https://learn.hashicorp.com/collections/terraform/aws-get-started

When you create a new configuration — or check out an existing configuration from version control — you need to initialize the directory with **terraform init** command.
You can also make sure your configuration is syntactically valid and internally consistent by using the **terraform validate** command.

The  **terraform apply**  command executes the actions proposed in a terraform template. All the default deployment variables may be changed. The variables will be explained in each of the proposed templates.


## Description of Terraform Templates

### LoadCore, two LoadCore Agents and the License Server 
Folder Name: loadcore_two_agents_and_license_server
The template deploys:
- One LoadCore in the management subnet
- Two LoadCore Agents with two interfaces each. The first interface will be used for mananagament and the second interface will be used for testing
- One LoadCode License Server in the management subnet

### LoadCore, two LoadCore Agents and the AWS infrastructure
Folder Name: loadcore_and_two_agents_full_setup
The template deploys:
- The AWS infrastructure: vpc, subnets, internet gateway, security groups.
- One LoadCore in the management subnet
- Two LoadCore Agents with two interfaces each. The first interface will be used for mananagament and the second interface will be used for testing

### LoadCore, two LoadCore Agents, the License Server and the AWS infrastructure
Folder Name: loadcore_two_agents_and_license_server_full_setup
The template deploys:
- The AWS infrastructure: vpc, subnets, internet gateway, security groups.
- One LoadCore in the management subnet
- Two LoadCore Agents with two interfaces each. The first interface will be used for mananagament and the second interface will be used for testing
- One LoadCode License Server in the management subnet