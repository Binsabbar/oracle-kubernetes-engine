resource "oci_identity_compartment" "compartment" {
  name           = "oce-demo"
  description    = "compartment that holds PoCs resource for Oracle K8s Engine"
  compartment_id = var.tenancy_ocid
}

module "network" {
  source = "./network"

  compartment_id = oci_identity_compartment.compartment.id
  name           = "ocevcn"
  cidr_block     = "192.168.0.0/16"
  private_subnets = {
    "kubernetes" = {
      cidr_block        = "192.168.10.0/24"
      security_list_ids = []
    },
    "data" = {
      cidr_block        = "192.168.11.0/24"
      security_list_ids = []
    }
    "k8s" = {
      cidr_block        = "192.168.12.0/24"
      security_list_ids = []
    }
  }

  public_subnets = {
    "public" = {
      cidr_block        = "192.168.200.0/24"
      security_list_ids = []
    }
  }
}

module "network_secuirty_groups" {
  source = "./network-sg"

  vcn_id         = module.network.vcn.id
  compartment_id = oci_identity_compartment.compartment.id
  network_security_groups = {
    ssh_access_public = {
      safe_ips = {
        direction = "INGRESS"
        protocol  = "tcp"
        port      = 22
        ips       = var.safe_ips
      }
    }

    private_subnets = {
      vcn_access = {
        direction = "INGRESS"
        protocol  = "all"
        port      = 0
        ips       = [module.network.vcn.cidr_block]
      }
      egress_to_internet = {
        direction = "EGRESS"
        protocol  = "all"
        port      = 0
        ips       = ["0.0.0.0/0"]
      }
    }
  }
}

module "kubernetes" {
  source = "./kubernetes"

  vcn_id                      = module.network.vcn.id
  compartment_id              = oci_identity_compartment.compartment.id
  cluster_name                = "kubernetes-poc-dev"
  cluster_env                 = "dev"
  enable_kubernetes_dashboard = true
  lb_subnet_ids               = [module.network.private_subnets["k8s"].id]
  node_pool_ssh_public_key    = var.jumpbox_autherized_keys
  availability_domain         = data.oci_identity_availability_domain.ad_1.name

  node_pools = {
    "small-pool" = {
      shape     = "VM.Standard.E2.1"
      size      = 2
      labels    = {"size": "small"}
      subnet_id = module.network.private_subnets["kubernetes"].id
    },
    "large-pool" = {
      shape     = "VM.Standard2.1"
      size      = 2
      labels    = {"size": "large"}
      subnet_id = module.network.private_subnets["kubernetes"].id
    }
  }
}