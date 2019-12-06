# Variable definitions
# Define the Datacenter group to deploy too
variable "vsphere_dc" {
  default = "CTO"
}
# Define the VM Datastore to use
variable "vsphere_ds" {
  default = "SGBCTO6302-VMFS"
}
# Define the VM Template to use
variable "source_vm" {
  default = "Win2016_Hardened_Patched_Sept2019_CTO_DEV"
}
# Denfine the resource pool to deploy too
variable "resource_pool" {
  default = "tf_automation"
}
# Define the number of resources to be deployed
# Define a prefix for the VM name and guest hostname
variable "name_prefix" {}
# Define the number of resouces VM's to be deployed
variable "countN" {}
# Define the number of cpus for the VM's
variable "num_cpus" {}
# Define the RAM for the VM's
variable "memory" {}
# Define the Virtual Network to use
variable "vm_network" {
  default = "CTO-Dev"
}
# Use an offset to start counting from a certain number
# or else the first server will be named server-01 and receive an ip address 192.168.105.51
variable "offset" {
  default = 0
}
# Start number in last octect of ipv4 address
variable "start_ipv4_address" {
  default = 29
}
# ipv4_gateway
variable "ipv4_gw" {
  default = "10.6.0.1"
}
# dns_server_list
variable "dns_servers" {
  default = ["10.6.1.54"]
}
# Local Administrator password = admin_password
variable "secretpw" {
  default = "DeLaRue2019!"
}
# Computer default Workgroup
variable "Cworkgroup" {
  default = "mllab.com"
}
// Win2016_Hardened_Patched_Sept2019
// username is baldrick
// password is DeLaRue2019!
