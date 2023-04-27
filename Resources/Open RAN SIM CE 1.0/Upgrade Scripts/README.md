### Keysight LoadCore update tool

##### IMPORTANT
Before running this tool against your setup, please backup LoadCore MDW resources: configurations, results.


Files used by this tool:

1. **updateLoadCore.exe** The Windows version

2. **updateLoadCore** The Linux version

3. **variables.ini** The configuration file

Before running the tool, the user needs to configure the variables.ini file:

- **LoadCoreMdwIP** - the IP address of the LoadCore MDW to be updated

- **updateMDW** - True/False

- **LoadCoreMdwUpgradeTar** - The LoadCore Mdw Upgrade tar name (relative path)

- **deleteAgents** - True/False Delete Agents from LoadCore Mdw. Useful when re-deploying the Agents.

- **updateAgents** - True/False

- **LoadCoreAgentsUpgradeTgz** - The LoadCore Agents Upgrade tgz name (relative path)


This tool can be used in multiple scenarios:


1. #### Update LoadCore MDW and LoadCore Agents
Updates the LoadCore MDW and the LoadCore Agents that are currently connected to the MDW.

**updateMDW** should be on **True**

**updateAgents** should be on **True**

**deleteAgents** should be on **False**



2. #### Update only LoadCore MDW 
Updates only the LoadCore MDW.

**updateMDW** should be on **True**

**updateAgents** should be on **False**

**deleteAgents** should be on **False**



3. #### Update only LoadCore MDW and delete Agents from MDW
Updates only the LoadCore MDW and deletes the Agents from MDW. Useful when re-deploying the Agents.

**updateMDW** should be on **True**

**updateAgents** should be on **False**

**deleteAgents** should be on **True**



4. #### Update only LoadCore Agents
Updates only the LoadCore Agents that are currently connected to MDW.

**updateMDW** should be on **False**

**updateAgents** should be on **True**

**deleteAgents** should be on **False**