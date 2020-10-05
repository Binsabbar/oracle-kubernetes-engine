locals {
  node_config = {
    "dev" = {
      size        = 2
      ocpus       = 2
      k8s_version = "v1.17.9"
      shape       = "VM.Standard.E2.1"
    }
    "production" = {
      size        = 6
      ocpus       = 4
      k8s_version = "v1.17.9"
      shape       = "VM.Standard.E2.1"
    }
  }
}