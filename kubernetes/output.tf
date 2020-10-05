data "oci_containerengine_cluster_kube_config" "cluster_kube_config" {
  #Required
  cluster_id = oci_containerengine_cluster.cluster.id
}

output "kube_config" {
  value = data.oci_containerengine_cluster_kube_config.cluster_kube_config.content
}