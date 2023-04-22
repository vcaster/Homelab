# Setup
* (still a work in progress...super jank)
## Manual / Ansible
* create a secrets file in the parent dir of the repo. use `.secrets-example` as a guide
* set up postgres sql `sudo docker run --name Terraform-PG -e POSTGRES_USER=Nope -e POSTGRES_PASSWORD=Nope -e POSTGRES_DB=terraform_backend -v ~/git/psql-terraform:/var/lib/postgresql/data -p 5432:5432 -d postgres`
* adjust the ip of the psql container in terraform workflow
* add the secrects in the github repo
* `cd Terraform`
* provision github runner `terraform apply -target vsphere_virtual_machine.gh-runner -var-file=../../.secrets`
* run the ansible Github-Runner (follow the readme)
* 

# Packer

* `sudo act -j packer-ubuntu22-04-server  -r -v -P ubuntu-latest=catthehacker/ubuntu:act-latest --secret-file=../.secrets`

# Terraform

## act
* `sudo act -j terraform  -r -v -P ubuntu-latest=catthehacker/ubuntu:act-latest --secret-file=../.secrets`
* debuging `terraform state list` || `terraform destroy -target vsphere_virtual_machine.gh-runner -var-file=../../.secrets` || `terraform plan -var-file=../../.secrets`

## github runner
* just push

# Credits
* sam (terraform and packer template)
* monolithprojects.github_actions_runner (git runner role)
* k32-ansible (tech-tim)
* * forked the repo and added a subtree 
* * `git subtree add --prefix Ansible/k3s-ansible git@github.com:vcaster/k3s-ansible.git master --squash`
* * after commit push to the forked repo
* * `git subtree push --prefix Ansible/k3s-ansible git@github.com:vcaster/k3s-ansible.git master`