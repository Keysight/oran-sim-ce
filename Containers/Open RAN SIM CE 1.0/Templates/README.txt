============
Introduction
============

The loadcore agent container needs to be run using root privileges and requires NET_ADMIN capabilities.
It also requires SCTP to be enabled.
There are several options to use the loadcore agent container: to use directly the container, to install it in Kubernetes or to install it in OpenShift.

==================================================
Using the loadcore agent docker container directly
==================================================
In order to use the loadcore agent directly from the Docker container, please follow the below steps:

1. Load the container:
%> docker load -i LoadCore-Agent-Docker-4.0.0.5.tar.gz

1. Create a new docker network:
%> docker network create loadcore-network

2. Create a new container from the loadcore agent image, specifying the middleware IP, the admin interface (eth0) and the test interface (eth1):
%> docker create --name loadcore-agent --cap-add=NET_ADMIN loadcore-agent:4.0.0.5-9b5afda2b1 MIDDLEWARE-IP eth0 eth1

3. Connect the container to the network created above:
%> docker network connect loadcore-network loadcore-agent
This will add an extra network interface, named eth1, in the container.

4. Start the container:
%> docker start loadcore-agent

===========================================
Installing the loadcore agent on Kubernetes
===========================================
Before installing the agent in Kubernetes, make sure that you have Multus installed.
See more information about installing and configuring Multus here:
https://github.com/intel/multus-cni/blob/master/docs/configuration.md

You can install the agent in kubernetes using the provided helm chart.
See more information about helm and how to install it here: https://helm.sh/

The configuration files referred in the steps below can be found in the 'kubernetes' directory.

In order to install the agent in Kubernetes, please follow the below steps:

1. Load the container:
%> docker load -i LoadCore-Agent-Docker-4.0.0.5.tar.gz

2. Tag the container in order to be pushed in your private docker registry:
%> docker tag loadcore-agent:4.0.0.5-9b5afda2b1 <PRIVATE-DOCKER-REGISTRY>/loadcore-agent:4.0.0.5-9b5afda2b1

3. Push the container in the private docker registry:
%> docker push <PRIVATE-DOCKER-REGISTRY>/loadcore-agent:4.0.0.5-9b5afda2b1

4. Create the keysight-loadcore-agent namespace:
%> kubectl create namespace keysight-loadcore-agent

5. Edit the 'my_values.yaml' configuration file and specify the following:
- your private docker registry (substitute PRIVATE-DOCKER-REGISTRY).
- the name of the kubernetes secret so that kubernetes to be able to pull the image from the docker registry (substitute PULL-SECRET-NAME).
- the number of agent replicas (substitute NUMBER-OF-REPLICAS).
- the IP of the middleware (substitute MIDDLEWARE-IP-ADDR).
- the agent test interfaces (you can specify that both net1 and net2 test interfaces will be used).
- the master ethernet interface to be used by the multus interface (substitute MASTER-ETH-INTERFACE).
You can also further tweak the multus agent settings, such as subnet range, gateway, etc.

6. Install the helm chart:
%> helm install -f my_values.yaml loadcore-agent ./load-core-agent-4.0.0-5+9b5afda2b1.20221219.tgz

7. Confirm that the agent is running:
%> kubectl get pods -n keysight-loadcore-agent

==========================================
Installing the loadcore agent on OpenShift
==========================================
Make sure that SCTP is enabled on the cluster. See more documentation about SCTP on OpenShift here:
https://docs.openshift.com/container-platform/4.5/networking/using-sctp.html

The configuration file referred in the steps below can be found in the 'openshift' directory.

In order to install the agent in OpenShift, please follow the below steps:

1. Login to the cluster internal registry using podman:
%> REGISTRY="$(oc -n openshift-image-registry get route default-route -o jsonpath='{.spec.host}')"
$> podman login --tls-verify=false -u unused -p $(oc whoami -t) ${REGISTRY}

2. Load the loadcore agent image:
%> podman load -i LoadCore-Agent-Docker-4.0.0.5.tar.gz

3. See the loaded image details:
%> podman images

4. Tag the loadcore image using the same image ID returned by 'podman images', for example:
%> podman tag b6c0239d09 $REGISTRY/loadcore/loadcore-agent:4.0.0.5-9b5afda2b1

5. Push the loadcore image to the internal image registry:
%> podman push --tls-verify=false $REGISTRY/loadcore/loadcore-agent:4.0.0.5-9b5afda2b1

6. We need to configure an extra interface to be used as test interface. Multus is already configured on OpenShift.
Here, is an example of how to add an additional network using Multus:
%> oc edit networks.operator.openshift.io cluster
than add the following:

spec:
  additionalNetworks:
    - name : loadcore-network
      namespace: loadcore
      type: Raw
      rawCNIConfig: '{"cniVersion": "0.3.1", "name": "loadcore-network", "type": "bridge", "master": "eth0", "ipam": { "type": "whereabouts", "range": "192.168.1.0/24", "exclude": ["192.168.1.0/32", "192.168.1.1/32", "192.168.1.254/32"]}}'

7. Get the loadcore image name the registry:
%> oc describe is loadcore-agent
Observe the image name, it is something like this:
image-registry.openshift-image-registry.svc:5000/loadcore/loadcore-agent@sha256:3425980b45b5512d998edf8f65518d8d95605d9fa9899f77e00a7a0c2ccde04e

8. Update the loadcore-agent-deployment.yaml file with the name of the image obtained at the previou setp and with the IP of the middleware (in the arguments section).
You can also modify the number of agent instances (see the replicas parameter inside the deployment file).

9. Apply the loadcore agent deployment:
%> oc apply -f loadcore-agent-deployment-loadcore.yaml
