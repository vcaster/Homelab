resource "vsphere_folder" "github" {
  datacenter_id = data.vsphere_datacenter.dc.id
  path          = "Github"
  type          = "vm"
}