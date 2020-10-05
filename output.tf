output "network" {
  value = {
    private = { for key, value in module.network.private_subnets : key => value.cidr_block }
    public  = { for key, value in module.network.public_subnets : key => value.cidr_block }
  }
}

output "networks_sg" {
  value = module.network_secuirty_groups.networks_sg
}

output "kube_config" {
  value = module.kubernetes.kube_config
}