### Keysight LoadCore terraform plans

These terraform plans and the updateLoadCore tool can be used together to managed LoadCore product across releases.


#### Example of usage:
Prerequisites in order to managed the LoadCore product across releases:

- deploy one LoadCore MDW using the terraform from **VMware\ESXi\terraform\one_loadcore_mdw**

- deploy the LoadCore Agents using the terraforms from **VMware\ESXi\terraform**

The updateLoadCore tool can be also used on an existing LoadCore setup.


#### Some deployment scenarios:

##### 1. update LoadCore MDW and LoadCore Agents:

* use **updateLoadCore** tool to update both MDW and Agents.



##### 2. update LoadCore MDW and re-deploy LoadCore Agents:

* use **updateLoadCore** tool to update LoadCore MDW (make sure to use deleteAgents flag to clean MDW of old agents)

* re-deploy agents using terraform plans (make sure to keep the terraform .tfstate file in order to delete them from the infrastructure)



##### 3. Re-deploy both LoadCore MDW and LoadCore Agents:

* Both actions can be done using terraforms plans from **VMware\ESXi\terraform**


#### Prerequisites
The prerequisites are:
- Latest version of Terraform installed. https://learn.hashicorp.com/tutorials/terraform/install-cli

#### How to use:

You can start learning terraform from the official website: https://learn.hashicorp.com/collections/terraform/aws-get-started

When you create a new configuration — or check out an existing configuration from version control — you need to initialize the directory with **terraform init** command.
You can also make sure your configuration is syntactically valid and internally consistent by using the **terraform validate** command.

The  **terraform apply**  command executes the actions proposed in a terraform template. All the default deployment variables may be changed. The variables will be explained in each of the proposed templates.


#### Short description of Terraform plans
For full description, please check the README.md from each folder

##### One LoadCore MDW
Terraform will deploy one LoadCore MDW on the specified ESXi infrastructure


##### Two LoadCore Agents
Terraform will deploy two LoadCore Agents on the specified ESXi infrastructure


##### Multiple LoadCore Agents
Terraform will deploy multiple LoadCore Agents on the specified ESXi infrastructure


##### One LoadCore MDW and two LoadCore Agents
Terraform will deploy one LoadCore MDW and two LoadCore Agents on the specified ESXi infrastructure