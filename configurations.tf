terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "binsabbar"
    workspaces {
      name = "oce-infra"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}