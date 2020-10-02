variable "compartment_id" { type = string }
variable "name" {
  type    = string
  default = "vaultvcn"
}

variable "cidr_block" {
  type    = string
  default = "192.168.0.0/16"
}

variable "allowed_ingress_ports" {
  type        = list(number)
  default     = [80, 443]
  description = "list of allowed ports for the public subnet"
}

variable "private_subnets" {
  type = map(object({
    cidr_block        = string
    security_list_ids = list(string)
  }))
}

variable "public_subnets" {
  type = map(object({
    cidr_block        = string
    security_list_ids = list(string)
  }))
}