# LoadCore, two LoadCore Agents and the AWS infrastructure

The template deploys:
- The AWS infrastructure: vpc, subnets, internet gateway, security groups.
- One LoadCore in the management subnet
- Two LoadCore Agents with two interfaces each. The first interface will be used for mananagament and the second interface will be used for testing

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
| allowed_cidr | ["0.0.0.0/0"] |List of ip allowed to access the deployed machines. Default value will provide access to everyone from the internet. |
| region            | us-east-1   | The AWS region for deployment. |
| availability_zone      | us-east-1a       | The AWS availability zone for deployment. |
| vpc_cidr      | "20.0.0.0/16"      | The VPC CIDR. |
| mgmt_subnet      | "20.0.0.0/24"      | The management CIDR. |
| test_subnet      | "20.0.1.0/24"      | The test CIDR. |
| agent1_test_private_IPs | ["20.0.1.12","20.0.1.13",...] | The list of private IPs to be associated with the test interface on agent1. |
| agent2_test_private_IPs | ["20.0.1.102","20.0.1.103",...] | The list of private IPs to be associated with the test interface on agent2. |


Other variables that can be modified in **variables.tf** file.

| **Parameter label (name)**                  | **Default**            | **Description**  |
| ----------------------- | ----------------- | ----- |
| loadcore_type   | c4.2xlarge   | The instance type used for deploying the LoadCore. |
| loadcore_agent_type    | c5.2xlarge   |The instance type used for deploying the LoadCore agent.  |

## Destruction

The **terraform destroy** command will destroy the previous deployed infrastructure.


# Post deployment
After successful deployment, please follow the next steps:
- Terraform will display the Outputs where you can find the LoadCore UI IP address. Always wait a few more minutes to boot-up.
- Default LoadCore UI username and password: admin/admin
- The LoadCore Agents should be automatically registered to LoadCore
