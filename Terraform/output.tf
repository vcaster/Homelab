output "ubuntu22-04-test-ip" {
  value = vsphere_virtual_machine.ubuntu22-04-test.guest_ip_addresses[0]
}