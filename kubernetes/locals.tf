locals {
  images_ids = {
    oracle_linux_7 = "ocid1.image.oc1.me-jeddah-1.aaaaaaaaaqsxujxurzktxkwx4umh3k7vawylcpi6qibvduvx4cuf5vctajea"
  }

  node_config = {
    "dev" = {
      k8s_version = "v1.17.9"
    }
    "production" = {
      k8s_version = "v1.17.9"
    }
  }
}