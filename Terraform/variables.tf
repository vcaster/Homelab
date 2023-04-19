#===========================#
# VMware vCenter connection #
#===========================#

variable "vsphere_user" {
  type        = string
  description = "VMware vSphere user name"
  sensitive = true
}

variable "vsphere_password" {
  type        = string
  description = "VMware vSphere password"
  sensitive = true
}

variable "vsphere_vcenter" {
  type        = string
  description = "VMWare vCenter server FQDN / IP"
  sensitive = true
}

variable "vsphere-unverified-ssl" {
  type        = string
  description = "Is the VMware vCenter using a self signed certificate (true/false)"
}

variable "vsphere-datacenter" {
  type        = string
  description = "VMWare vSphere datacenter"
}

variable "vsphere-cluster" {
  type        = string
  description = "VMWare vSphere cluster"
  default     = ""
}

variable "vsphere-template-folder" {
  type        = string
  description = "Template folder"
  default = "Templates"
}

#================================#
# VMware vSphere virtual machine #
#================================#

variable "vm-datastore" {
  type        = string
  description = "Datastore used for the vSphere virtual machines"
}

variable "vm-network" {
  type        = string
  description = "Network used for the vSphere virtual machines"
}

variable "vm-linked-clone" {
  type        = string
  description = "Use linked clone to create the vSphere virtual machine from the template (true/false). If you would like to use the linked clone feature, your template need to have one and only one snapshot"
  default     = "false"
}

variable "cpu" {
  description = "Number of vCPU for the vSphere virtual machines"
  default     = 2
}

variable "cores-per-socket" {
  description = "Number of cores per cpu for workers"
  default     = 1
}

variable "ram" {
  description = "Amount of RAM for the vSphere virtual machines (example: 2048)"
}

variable "disksize" {
  description = "Disk size, example 100 for 100 GB"
  default = ""
}

variable "vm-guest-id" {
  type        = string
  description = "The ID of virtual machines operating system"
}

variable "ubuntu2204-server-template-name" {
  type        = string
  description = "The template to clone to create the VM"
}

variable "vm-domain" {
  type        = string
  description = "Linux virtual machine domain name for the machine. This, along with host_name, make up the FQDN of the virtual machine"
  default     = ""
}

variable "dns_server_list" {
  type = list(string)
  description = "List of DNS servers"
  default = ["10.10.10.51", "10.10.10.1"]
}

variable "ipv4_gateway" {
  type = string
}

variable "ipv4_netmask" {
  type = string
}

variable "ssh_username" {
  type      = string
  sensitive = true
  default   = "ubuntu"
}

variable "public_key" {
  type        = string
  description = "Public key to be used to ssh into a machine"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKvw1x+YO5wQ33cd8+irxIuNYPBsrCWWlABfUsjfDlhiN8zrOS1m3QwNW1xj04VXo7xw5VwyWWLuOZa2FZ0DhhDsp14vh+SPt9uK5yYFxydX/waL+/eQ4W3MBg/JGnXopzpBYsbX45TETZytxLvGKJISUmWAeqLza8wu7M0cPtfewmB9Rs8pQfwRVoxuH4RbF5a81TWlQTYPAuuFE7wj+9hln0zOIFlGKZPhu3K/SmXbrKs1ldwvUYRytHGm3FpuNg1D4tLbdUWvWDjI3eFdvNsmd3ffyoBRPaxM5m6yeHNW6lR05Gr79GHyE6eKImZpNFVMZ3ViyTL3KNiqMCBE8H kali@kali"
}

#================================#
# VMware vSphere ubuntu22-04-test#
#================================#

variable "ubuntu22-04-test" {
  type        = string
  description = "The name of the vSphere virtual machines and the hostname of the machine"
}

variable "ubuntu22-04-test-ipv4_address" {
  type = string
  description = "ipv4 addresses for a vm"
}

#================================#
# VMware vSphere gh-runner       #
#================================#

variable "gh-runner" {
  type        = string
  description = "The name of the vSphere virtual machines and the hostname of the machine"
}

variable "gh-runner-ipv4_address" {
  type = string
  description = "ipv4 addresses for a vm"
}

#================================#
# VMware vSphere kubernetes      #
#================================#

variable "kubernetes" {
  type        = list(object({
    name = string
    cpus = number
    cores_per_socket = number
    ram = number
    disk_size = number
    ip_addr = string
  }))
  description = "The name of the vSphere virtual machines and the hostname of the machine"
}