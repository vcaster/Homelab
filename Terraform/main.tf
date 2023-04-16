terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.2.0"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_vcenter
  allow_unverified_ssl = true
}

locals {
  ubuntu2204-server-templatevars = {
    name         = var.ubuntu22-04-test,
    ipv4_address = var.ubuntu22-04-test-ipv4_address,
    ipv4_gateway = var.ipv4_gateway,
    dns_server_1 = var.dns_server_list[0],
    dns_server_2 = var.dns_server_list[1],
    public_key = var.public_key,
    ssh_username = var.ssh_username
  }
}

# Define VMware vSphere 
data "vsphere_datacenter" "dc" {
  name = var.vsphere-datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vm-datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere-cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vm-network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "ubuntu2204-server-template" {
  name          = "/${var.vsphere-datacenter}/vm/${var.vsphere-template-folder}/${var.ubuntu2204-server-template-name}"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "ubuntu22-04-test" {
  name             = var.ubuntu22-04-test
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder               = "Proving Grounds"

  num_cpus             = var.cpu
  num_cores_per_socket = var.cores-per-socket
  memory               = var.ram
  guest_id             = var.vm-guest-id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.ubuntu2204-server-template.network_interface_types[0]
  }

  disk {
    label            = "${var.ubuntu22-04-test}-disk"
    thin_provisioned = data.vsphere_virtual_machine.ubuntu2204-server-template.disks.0.thin_provisioned
    eagerly_scrub    = data.vsphere_virtual_machine.ubuntu2204-server-template.disks.0.eagerly_scrub
    size             = var.disksize == "" ? data.vsphere_virtual_machine.ubuntu2204-server-template.disks.0.size : var.disksize 
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu2204-server-template.id
  }
  extra_config = {
    "guestinfo.metadata"          = base64encode(templatefile("${path.module}/templates/ubuntu2204-server-metadata.yaml", local.ubuntu2204-server-templatevars))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata"          = base64encode(templatefile("${path.module}/templates/ubuntu2204-server-userdata.yaml", local.ubuntu2204-server-templatevars))
    "guestinfo.userdata.encoding" = "base64"
  }
  lifecycle {
    ignore_changes = [
      annotation,
      clone[0].template_uuid,
      clone[0].customize[0].dns_server_list,
      clone[0].customize[0].network_interface[0]
    ]
  }
}
