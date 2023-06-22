## 1. gNB-sim & DN, 200k UEs, 10 Gbps
Config folder: gNB-sim&DN-200kUEs-10Gbps 

#### Recommended PAYG instances:
NGRAN - 1 x **c5.9xlarge** OR 1 x **m5.8xlarge**

DN - 1 x **c5n.4xlarge**


#### Other recommended settings on LoadCore Agent
kernel boot parameters:
-  hugepages=8000
-  maxcpus=16




## 2. gNB-sim & DN, 1M UEs, 10 Gbps
Config folder: gNB-sim&DN-1M-UEs-10Gbps

#### Recommended PAYG instances:
NGRAN - 2 x **c5.9xlarge** OR 2 x **m5.8xlarge**

DN - 1 x **c5n.4xlarge**


#### Other recommended settings on LoadCore Agent
kernel boot parameters:
-  hugepages=8000
-  maxcpus=16




## 3. SMF/UPF Isolation, 200k Ues, 20 Gbps
Config folder: SMF-UPF-Isolation-200kUEs-20Gbps

#### Recommended PAYG instances:
NGRAN - 2 x **c5.18xlarge**

DN - 1 x **c5n.4xlarge**


#### Other recommended settings on LoadCore Agent
kernel boot parameters:
-  hugepages=8000
-  maxcpus=16




## 4. gNB-sim & DN, 1M UEs, 20 Gbps
Config folder: gNB-sim&DN-1M-UEs-20Gbps

#### Recommended PAYG instances:
NGRAN - 3 x **c5.18xlarge**

DN - 1 x **c5n.4xlarge**


#### Other recommended settings on LoadCore Agent
kernel boot parameters:
-  hugepages=8000
-  maxcpus=16




## 5. UPF isolation, 100k UEs, 20 Gbps
Config folder: UPFisolation-100kUEs-20Gbps
#### Recommended PAYG instances:
NGRAN - 1 x **c5n.18xlarge**

DN - 1 x **c5n.4xlarge**


#### Other recommended settings on LoadCore Agent
kernel boot parameters:
-  hugepages=8000
-  maxcpus=16