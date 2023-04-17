output "ubuntu22-04-test-ip" {
  value = vsphere_virtual_machine.ubuntu22-04-test.guest_ip_addresses[0]
}

output "gh-runner-ip" {
value = vsphere_virtual_machine.gh-runner.guest_ip_addresses[0]
}
