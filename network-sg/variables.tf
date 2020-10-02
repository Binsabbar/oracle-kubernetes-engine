variable "vcn_id" { type = string }
variable "compartment_id" { type = string }
variable "network_security_groups" {
  type = map(map(object({
    direction = string
    protocol  = string
    port      = number
    ips       = set(string)
  })))

  default = {}
}