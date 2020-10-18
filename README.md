# oracle-kubernetes-engine
Playground for configuring and setting up Kubernetes in Oracle Cloud using Terraform


## Setup:
The repo will create the following:
1. One VCN with 3 subnets
    1. 1 public subnet: `public`
    2. 3 private subnets: `data`, `kubernetes` and `k8s`
    
 Note: `main.tf` contains `cidr` information under `module "network"` block.
  
2. K8S cluster with the following:
    1. 2 Node Pools each pool has two instances (worker nodes)
 
3. 2 security groups:
    1. `ssh_access_public`: allows incoming connections to port 22 from safe ips
    2. `private_subnets`: allow vcn internal connection and outgoing connection to public via nat_gateway.


## Getting Started
pass in the required variables as specified in `variables.tf` in a file called `.auto.tfvars`, then run `terraform apply`
