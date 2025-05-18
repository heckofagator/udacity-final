variable "subnet_id" {
  description = "ID of the subnet to attach the NIC to"
  type        = string
}
variable "public_ip" {
  description = "public IP"
  type        = string
}
variable "network_interface_id" {
  description = "ID of the network interface"
  type        = string
}