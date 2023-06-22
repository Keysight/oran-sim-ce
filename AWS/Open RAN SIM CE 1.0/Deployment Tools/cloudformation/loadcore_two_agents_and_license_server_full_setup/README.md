# Deploying LoadCore, two LoadCore Agents, a License Server and the AWS infrastructure

The template deploys:
- Creates a new VPC with 2 CIDRs: 10.0.0.0/16 for management and 20.0.0.0/16 for testing
- Create two security groups: one for management (with multiple ingress rules for accessing the LoadCore UI and to allow SSH) and one for testing
- Creates and attaches an internet gateway to the management subnet for internet access
- Create two subnets: one for management (10.0.0.0/24 CIDR) and one for testing (20.0.0.0/16 CIDR)
- One LoadCore in the management subnet
- Two LoadCore Agents with two interfaces each. The first interface will be used for mananagament and the second interface will be used for testing
- One LoadCode License Server in the management subnet

The LoadCore Agents will also have multiple private IPs to be used in testing:
Agent1 Private IP Addresses: "20.0.4.12, 20.0.4.13, 20.0.4.14, 20.0.4.15, 20.0.4.16, 20.0.4.17, 20.0.4.18, 20.0.4.19, 20.0.4.20, 20.0.4.21"
Agent2 Private IP Addresses: "20.0.5.12, 20.0.5.13, 20.0.5.14, 20.0.5.15, 20.0.5.16, 20.0.5.17, 20.0.5.18, 20.0.5.19, 20.0.5.20, 20.0.5.21"

IMPORTANT!!! When deleting the stack, the License Server will be also deleted along with the activated licenses.
The user should first de-activate the licenses before manually terminating the instance. This will prevent the licenses to remain activated on a deleted instance.
By default, the License Server Volume will not be deleted along with the instance for recovery purposes.

The following table lists the parameters for this deployment.

| **Parameter label (name)**                   | **Default**            | **Description**  |
| ----------------------- | ----------------- | ----- |
| Stack name            | Requires input   | Specify the deployment stack name. |
| User Email      | Requires input       | Email ID of the stack owner. All resources created by this stack are tagged with User Email. |
| Instance type of LoadCore | c4.2xlarge | The EC2 instance type to use for the Keysight Loadcore. |
| Instance type of LoadCore Agents | c5.2xlarge | The EC2 instance type to use for the Keysight Loadcore Agents. |
| Instance type of LoadCore Licensing | t2.medium | The EC2 instance type to use for the Keysight Loadcore License Server. |
| Key Name                   | Select Key from drop down            | Name of an existing EC2 KeyPair to enable SSH access to the LoadCore instances.  |
| AllowedSubnet | 0.0.0.0/0 | The subnet that will be allowed to access the deployed AWS instances. The default value will allow everyone from internet to access them |


# Post deployment
After successful deployment of stack, please follow the next steps:
- Go to Outputs and check the LoadCore UI Elastic IP. Always wait a few more minutes to boot-up.
- Default LoadCore UI username and password: admin/admin
- The LoadCore Agents should be automatically registered to LoadCore