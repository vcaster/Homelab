resource "vsphere_virtual_machine" "kube" {
  count = length(var.kubernetes)
  name             = var.kubernetes[count.index].name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder               = "Kubernetes"

  num_cpus             = var.kubernetes[count.index].cpus
  num_cores_per_socket = var.kubernetes[count.index].cores_per_socket
  memory               = var.kubernetes[count.index].ram
  guest_id             = var.vm-guest-id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.ubuntu2204-server-template.network_interface_types[0]
  }

  disk {
    label            = "${var.kubernetes[count.index].name}-disk"
    thin_provisioned = data.vsphere_virtual_machine.ubuntu2204-server-template.disks.0.thin_provisioned
    eagerly_scrub    = data.vsphere_virtual_machine.ubuntu2204-server-template.disks.0.eagerly_scrub
    size             = var.kubernetes[count.index].disk_size
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu2204-server-template.id
  }
  extra_config = {
    "guestinfo.metadata"          = base64encode(templatefile("${path.module}/templates/ubuntu2204-server-metadata.yaml", {
        name         = var.kubernetes[count.index].name,
        ipv4_address = var.kubernetes[count.index].ip_addr,
        ipv4_gateway = var.ipv4_gateway,
        dns_server_1 = var.dns_server_list[0],
        dns_server_2 = var.dns_server_list[1],
        public_key = var.public_key,
        ssh_username = var.ssh_username
    }))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata"          = base64encode(templatefile("${path.module}/templates/ubuntu2204-server-userdata.yaml", {
        name         = var.kubernetes[count.index].name,
        ipv4_address = var.kubernetes[count.index].ip_addr,
        ipv4_gateway = var.ipv4_gateway,
        dns_server_1 = var.dns_server_list[0],
        dns_server_2 = var.dns_server_list[1],
        public_key = var.public_key,
        ssh_username = var.ssh_username
    }))
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