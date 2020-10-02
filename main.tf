resource "oci_identity_compartment" "compartment" {
  name           = "oce-demo"
  description    = "compartment that holds PoCs resource for Oracle K8s Engine"
  compartment_id = var.tenancy_ocid
}

module "network" {
  source = "./network"

  compartment_id = oci_identity_compartment.compartment.id
  name = "ocevcn"
  cidr_block = "192.168.0.0/16"
  private_subnets = {
    "kubernetes" = {
      cidr_block = "192.168.10.0/24"
      security_list_ids = []
    },
    "data" = {
      cidr_block = "192.168.11.0/24"
      security_list_ids = []
    }
  }

  public_subnets = {
    "public" = {
      cidr_block = "192.168.200.0/24"
      security_list_ids = []
    }
  }
}