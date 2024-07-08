### One LoadCore MDW and two LoadCore Agents

The template deploys:
- One LoadCore in the specified management network

The folder contains three files:

**main.tf** contains the main set of configuration

**variables.tf** contains the variable definitions. The variables can be also modified from here.

**terraform.tfvars** is a variable definitions file in which you can provide values for variables


## Template variables
In order to modify the default values, you should modify the **terraform.tfvars** file.

| **Parameter label (name)**                  | **Default**            | **Description**  |
| ----------------------- | ----------------- | ----- |
| esxi_hostname | Requires input | The ESXi hostname/ip. |
| esxi_username  | Requires input | The ESXi username. |
| esxi_password  | Requires input | The ESXi password. |
| esxi_datastore | Requires input | The ESXi datastore name. |
| loadcore_mdw_image_path | Requires input | Specify the full path to LoadCore MDW Ova image. |
| management_network | Requires input | Specify the name of the Virtual Machine Port Group for management. |
| vm_prefix | Requires input | Specify a prefix for the VMs name. |


## Destruction

The **terraform destroy** command will destroy the previous deployed infrastructure.


# Post deployment
After successful deployment, please follow the next steps:
- Terraform will display the Outputs where you can find the LoadCore UI IP address. Always wait a few more minutes to boot-up.
- Default LoadCore UI username and password: admin/admin
- The LoadCore Agents should be automatically registered to LoadCore MDW