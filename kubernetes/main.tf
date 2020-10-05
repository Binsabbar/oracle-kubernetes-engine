resource "oci_containerengine_cluster" "cluster" {
  compartment_id     = var.compartment_id
  name               = var.cluster_name
  vcn_id             = var.vcn_id
  kubernetes_version = local.node_config["${var.cluster_env}"].k8s_version

  options {
    add_ons {
      is_kubernetes_dashboard_enabled = var.enable_kubernetes_dashboard
      is_tiller_enabled               = true
    }
    service_lb_subnet_ids = var.lb_subnet_ids
  }
}

resource "oci_containerengine_node_pool" "node_pool" {
  cluster_id         = oci_containerengine_cluster.cluster.id
  compartment_id     = var.compartment_id
  kubernetes_version = local.node_config["${var.cluster_env}"].k8s_version
  name               = "${var.cluster_env} node pool"
  node_shape         = local.node_config["${var.cluster_env}"].shape
  ssh_public_key     = var.node_pool_ssh_public_key

  node_config_details {
    size = local.node_config["${var.cluster_env}"].size
    placement_configs {
      availability_domain = var.availability_domain
      subnet_id           = var.subnet_id
    }
  }

  node_source_details {
    image_id    = local.images_ids.oracle_linux_7
    source_type = "IMAGE"
  }
}