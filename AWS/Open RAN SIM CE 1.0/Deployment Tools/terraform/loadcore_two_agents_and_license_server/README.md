# LoadCore, two LoadCore Agents and the License Server 

The template deploys:
- One LoadCore in the management subnet
- Two LoadCore Agents with two interfaces each. The first interface will be used for mananagament and the second interface will be used for testing
- One LoadCode License Server in the management subnet

The AWS infrastructure should already exist in order to use this terraform template.

The folder contains three files:
**main.tf** contains the main set of configuration
**variables.tf** contains the variable definitions. The variables can be also modified from here.
**terraform.tfvars** is a variable definitions file in which you can provide values for variables

## Template variables
In order to modify the default values, you should modify the **terraform.tfvars** file.

| **Parameter label (name)**                  | **Default**            | **Description**  |
| ----------------------- | ----------------- | ----- |
| aws_access_key | Requires input | The AWS access key must be obtained using following specification https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html. |
| aws_secret_key  | Requires input | The AWS secret key must be obtained using following specification https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html. |
| stack_name | Requires input |The AWS stack name. |
| ssh_key | Requires input | Specify an existing AWS SSH key name. |
| mgmt_security_group | Requires input | An existing security group for management. This should accept HTTP and HTTPs traffic on inbound for accessing LoadCore UI |
| test_security_group | Requires input | An existing security group for testing. |
| region            | us-east-1   | The AWS region for deployment. |
| availability_zone      | us-east-1a       | The AWS availability zone for deployment. |
| vpc_cidr      | "20.0.0.0/16"      | The VPC CIDR. |
| mgmt_subnet      | Requires input      | The management subnet id. |
| test_subnet      | Requires input      | The test subnet id. |
| no_of_private_ips_agents | 10 | The number of private IPs to be attached on each agent test interface. |


Other variables that can be modified in **variables.tf** file.

| **Parameter label (name)**                  | **Default**            | **Description**  |
| ----------------------- | ----------------- | ----- |
| loadcore_type   | c4.2xlarge   | The instance type used for deploying the LoadCore. |
| loadcore_agent_type    | c5.2xlarge   |The instance type used for deploying the LoadCore agent.  |
| loadcore_license_server_type    | t2.medium   |The instance type used for deploying the LoadCore License Server.  |

## Destruction

When destroying the infrastructure, the License Server will be also deleted along with the activated licenses.
The user should first de-activate the licenses before destroying the infrastructure. This will prevent the licenses to remain activated on a deleted instance.

The **terraform destroy** command will destroy the previous deployed infrastructure.


# Post deployment
After successful deployment, please follow the next steps:
- Terraform will display the Outputs where you can find the LoadCore UI IP address. Always wait a few more minutes to boot-up.
- Default LoadCore UI username and password: admin/admin
- The LoadCore Agents should be automatically registered to LoadCore
