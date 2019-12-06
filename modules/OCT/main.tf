data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_dc}"
}
# Datastore to deploy too
data "vsphere_datastore" "datastore" {
  name          = "${var.vsphere_ds}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
# Resourse Pool to deploy too
data "vsphere_resource_pool" "pool" {
  name          = "${var.resource_pool}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
# Virtual Network to use
data "vsphere_network" "network" {
  name          = "${var.vm_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
# Virtual Machine image to use
data "vsphere_virtual_machine" "template" {
  name          = "${var.source_vm}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
# Deploy resources
resource "vsphere_virtual_machine" "ad_vm" {
  count = "${var.countN}"
  # Define VM name using the resource count +1 making the first name xxx_xx_1
  name                   = "${var.name_prefix}${format("%01d", count.index + 1 + var.offset)}"
  resource_pool_id       = "${data.vsphere_resource_pool.pool.id}"
  datastore_id           = "${data.vsphere_datastore.datastore.id}"
  num_cpus               = "${var.num_cpus}"
  memory                 = "${var.memory}"
  cpu_hot_add_enabled    = true
  memory_hot_add_enabled = true
  guest_id               = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type              = "${data.vsphere_virtual_machine.template.scsi_type}"
  network_interface {
    network_id = "${data.vsphere_network.network.id}"
    # Below value is to use the template network type, or override as in the 2nd option below
    #adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
    adapter_type = "vmxnet3"
  }
  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    # Customise windows settings
    customize {
      windows_options {
        # Define hostname using the resource count +1 making the first name server-01
        computer_name = "${var.name_prefix}${format("%01d", count.index + 1 + var.offset)}"
        workgroup     = "${var.Cworkgroup}"
        #join_domain = "${var.domain}"
        #domain_admin_user = "${var.domainuser}"
        #domain_admin_password = "${var.domainuserpw}"
        admin_password = "${var.secretpw}"
      }
      network_interface {
        ipv4_address = "${format("10.6.1.%d", (count.index + 1 + var.offset + var.start_ipv4_address))}"
        ipv4_netmask = 23
      }
      ipv4_gateway    = "${var.ipv4_gw}"
      dns_server_list = "${var.dns_servers}"
    }
  }
}
