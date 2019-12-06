# Initialize vSphere provider, variables can be assigned with the var-file terraform parameter
provider "vsphere" {
  vsphere_server = "${var.vsphere_server}"
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  # If you have a self-signed cert
  allow_unverified_ssl = true
}
// update each module below to the required parameters
module "AD" {
  source      = "../modules/AD"
  memory      = 4096
  num_cpus    = 1
  countN      = 4
  name_prefix = "ad-dev-"
}
module "DB" {
  source      = "../modules/DB"
  memory      = 4096
  num_cpus    = 4
  countN      = 6
  name_prefix = "db-dev-"
}
module "IIS" {
  source      = "../modules/IIS"
  memory      = 2048
  num_cpus    = 2
  countN      = 4
  name_prefix = "iis-dev-"
}
module "OCT" {
  source      = "../modules/OCT"
  memory      = 2048
  num_cpus    = 2
  countN      = 4
  name_prefix = "oct-dev-"
}
