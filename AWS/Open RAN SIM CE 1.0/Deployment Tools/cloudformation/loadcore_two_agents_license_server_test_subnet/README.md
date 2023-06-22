# LoadCore, two LoadCore Agents, License Server and one custom test subnet

The template deploys:
- One LoadCore in the management subnet
- Two LoadCore Agents with two interfaces each. The first interface will be used for mananagament and the second interface will be used for testing
- It will create a new test subnet which will be used as test subnet for the two LoadCore Agents. Ten private IPs will be automatically added on test interface on each Agent to be used in tests.

Subnet CIDR: 20.0.0.0/16
Agent1 Private IP Addresses: "20.0.4.12, 20.0.4.13, 20.0.4.14, 20.0.4.15, 20.0.4.16, 20.0.4.17, 20.0.4.18, 20.0.4.19, 20.0.4.20, 20.0.4.21"
Agent2 Private IP Addresses: "20.0.5.12, 20.0.5.13, 20.0.5.14, 20.0.5.15, 20.0.5.16, 20.0.5.17, 20.0.5.18, 20.0.5.19, 20.0.5.20, 20.0.5.21"

When deleting the stack, the License Server will be skipped and the user should first de-activate the licenses before manually terminating the instance. This will prevent the licenses to remain activated on a deleted instance.

The following table lists the parameters for this deployment.

| **Parameter label (name)**                   | **Default**            | **Description**  |
| ----------------------- | ----------------- | ----- |
| Stack name            | Requires input   | Specify the deployment stack name. |
| User Email      | Requires input       | Email ID of the stack owner. All resources created by this stack are tagged with User Email. |
| Instance type of LoadCore | c4.2xlarge | The EC2 instance type to use for the Keysight Loadcore. |
| Instance type of LoadCore Agents | c5.2xlarge | The EC2 instance type to use for the Keysight Loadcore Agents. |
| Instance type of LoadCore Licensing | t2.medium | The EC2 instance type to use for the Keysight Loadcore License Server. |
| Key Name                   | Select Key from drop down            | Name of an existing EC2 KeyPair to enable SSH access to the LoadCore instances.  |
| VPC for creating a test subnet  | Select VPC from drop down            | Name of an existing VPC to create a new subnet inside it.  |
| Management Subnet | Select subnet from drop down | Existing Management subnet for LoadCore instances. This subnet should be used for accessing the UI and for the manangement traffic between instances. |
| Security group for management subnet | Select security group from drop down | The Security group used for management subnet. |
| Security group for test subnet | Select security group from drop down | The Security group used for test subnet. |


# Post deployment
After successful deployment of stack, please follow the next steps:
- Go to Outputs and check the LoadCore UI Elastic IP. Always wait a few more minutes to boot-up.
- Default LoadCore UI username and password: admin/admin
- The LoadCore Agents should be automatically registered to LoadCore