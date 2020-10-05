variable "vcn_id" {
  type = string
}

variable "compartment_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_env" {
  type        = string
  description = "The environment of the cluster: dev or production"
}

variable "enable_kubernetes_dashboard" {
  type = bool
}

variable "lb_subnet_ids" {
  type = list(string)
}

variable "node_pool_ssh_public_key" {
  type = string
}

variable "availability_domain" {
  type = string
}

variable "subnet_id" {
  type = string
}