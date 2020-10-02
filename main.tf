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