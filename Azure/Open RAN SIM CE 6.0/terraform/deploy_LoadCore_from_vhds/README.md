# Terraform templates

## Prerequisites
The prerequisites are:
- Latest version of Terraform installed. https://learn.hashicorp.com/tutorials/terraform/install-cli
- Authenticate to Azure platform usign Azure CLI tool. https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli

## How to use:

You can start learning terraform from the official website: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

Before running any terraform command, you need to authenticate using Azure CLI.

When you create a new configuration — or check out an existing configuration from version control — you need to initialize the directory with **terraform init** command.
You can also make sure your configuration is syntactically valid and internally consistent by using the **terraform validate** command.

The  **terraform apply**  command executes the actions proposed in a terraform template. All the default deployment variables may be changed. The variables will be explained in each of the proposed templates.


### One LoadCore MDW and two LoadCore Agents

The template deploys Virtual Machine using **VHD files**:
- One LoadCore MDW
- Two LoadCore Agents with three interfaces each. The first interface will be used for mananagament and the rest of the interfaces will be used for testing
Each test interface will get 8 private IPs.

The folder contains three files:

**main.tf** contains the main set of configuration

**variables.tf** contains the variable definitions. The variables can be also modified from here.

**terraform.tfvars** is a variable definitions file in which you can provide values for variables


## Template variables
In order to modify the default values, you should modify the **terraform.tfvars** file.

| **Parameter label (name)**                  | **Default**            | **Description**  |
| ----------------------- | ----------------- | ----- |
| prefix | Requires input |The Azure stack name. |
| ssh_key_name | Requires input | Specify an existing Azure SSH key name. |
| allowed_cidr | ["0.0.0.0/0"] |List of ip allowed to access the deployed machines. Default value will provide access to everyone from the internet. |
| location            | "eastus"   | The Azure region for deployment. |
| loadcore_mdw_blob_uri     | Requires input   | The full blob uri where the vhd exists |
| loadcore_agent_blob_uri     | Requires input   | The full blob uri where the vhd exists |
| loadcore_mdw_size     | Standard_D8s_v3   | The VM size |
| loadcore_agents_size     | Standard_F4s   | The VM size |
| virtual_network_cidr      | "10.0.0.0/16"      | The Virtual Network CIDR. |
| virtual_network_mgmt_subnet      | "10.0.0.0/24"      | The management CIDR. |
| virtual_network_test_subnet      | "10.0.1.0/24"      | The test CIDR. |


## Destruction

The **terraform destroy** command will destroy the previous deployed infrastructure.


# Post deployment
After successful deployment, please follow the next steps:
- Terraform will display the Outputs where you can find the LoadCore UI IP address. Always wait a few more minutes to boot-up.
- Terraform will also display what private IPs can be used in LoadCore test for each test interface.
- Default LoadCore UI username and password: admin/admin
- The LoadCore Agents should be automatically registered to LoadCore MDW