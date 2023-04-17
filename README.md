# Packer

* `sudo act -j packer-ubuntu22-04-server  -r -v -P ubuntu-latest=catthehacker/ubuntu:act-latest --secret-file=../.secrets`

# Terraform

* `sudo act -j terraform  -r -v -P ubuntu-latest=catthehacker/ubuntu:act-latest --secret-file=../.secrets`
* debuging `terraform destroy -target=vsphere_virtual_machine.gh-runner -var-file=../../.secrets` || `terraform plan -var-file=../../.secrets`