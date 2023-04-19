resource "vsphere_folder" "github" {
  datacenter_id = data.vsphere_datacenter.dc.id
  path          = "Github"
  type          = "vm"
}

resource "vsphere_folder" "Kubernetes" {
  datacenter_id = data.vsphere_datacenter.dc.id
  path          = "Kubernetes"
  type          = "vm"
}