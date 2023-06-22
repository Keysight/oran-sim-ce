# Deploying LoadCore, three LoadCore Agents and a License Server in AWS

The template deploys:
- One LoadCore in the management subnet
- Three LoadCore Agents with two interfaces each. The first interface will be used for mananagament and the second interface will be used for testing
- This setup can be used when planning to run tests with Application traffic (Raw Sockets)
- One LoadCode License Server in the management subnet

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
| Management Subnet | Select subnet from drop down | Existing Management subnet for LoadCore instances. This subnet should be used for accessing the UI and for the manangement traffic between instances. |
| Test Subnet | Select subnet from drop down | Existing Test subnet for LoadCore Agents. It is used for traffic between Agents.  |
| Security group for management subnet | Select security group from drop down | The Security group used for management subnet. |
| Security group for test subnet | Select security group from drop down | The Security group used for test subnet. |


# Post deployment
After successful deployment of stack, please follow the next steps:
- Go to Outputs and check the LoadCore UI Elastic IP. Always wait a few more minutes to boot-up.
- Default LoadCore UI username and password: admin/admin
- The LoadCore Agents should be automatically registered to LoadCore