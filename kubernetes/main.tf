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
  for_each = var.node_pools

  cluster_id          = oci_containerengine_cluster.cluster.id
  compartment_id      = var.compartment_id
  kubernetes_version  = local.node_config["${var.cluster_env}"].k8s_version
  name                = "${each.key} node pool"
  node_shape          = each.value.shape
  ssh_public_key      = var.node_pool_ssh_public_key
  dynamic "initial_node_labels" {
    for_each = each.value.labels
    content {
      key = initial_node_labels.key
      value = initial_node_labels.value
    }
  }

  node_config_details {
    size = each.value.size
    placement_configs {
      availability_domain = var.availability_domain
      subnet_id           = each.value.subnet_id
    }
  }

  node_source_details {
    image_id    = local.images_ids.oracle_linux_7
    source_type = "IMAGE"
  }
}