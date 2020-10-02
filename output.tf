output "network" {
  value = {
    private = module.network.private_subnets
    public = module.network.public_subnets
  }
}