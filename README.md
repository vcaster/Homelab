# Setup
* (still a work in progress...super jank)
## Manual / Ansible
* postgres example here is depricated, see postgres header below
* create a secrets file in the parent dir of the repo. use `.secrets-example` as a guide
* set up postgres sql `docker run --name Terraform-PG -e POSTGRES_USER=Nope -e POSTGRES_PASSWORD=Nope -e POSTGRES_DB=terraform_backend -v ~/git/Forbidden-Fruit/psql-terraform:/var/lib/postgresql/data -p 5432:5432 -d postgres`
* adjust the ip of the psql container in terraform workflow
* add the secrects in the github repo
* `cd Terraform`
* provision github runner `terraform apply -target vsphere_virtual_machine.gh-runner -var-file=../../.secrets`
* run the ansible Github-Runner (follow the readme)
* authelia test `docker run --name Authelia-PG -e POSTGRES_USER=Nope -e POSTGRES_PASSWORD=Nope -e POSTGRES_DB=authelia -v ~/git/Forbidden-Fruit/psql-authelia-test:/var/lib/postgresql/data -p 5433:5432 -d postgres`
* authelia `docker run --name Authelia-PG-Real -e POSTGRES_USER=Nope -e POSTGRES_PASSWORD=Nope -e POSTGRES_DB=authelia -v ~/git/Forbidden-Fruit/psql-authelia:/var/lib/postgresql/data -p 5434:5432 -d postgres`

## Ansible / Commander

* configures zabbix agents, node-exporter, promtail, system (hostname, extra_packages)
* sets up a zimaboard for containers
* * uptime-kuma for external monitoring
* * postgres db
* run whole `ansible-playbook main.yml`
* run with tags `ansible-playbook main.yml --tags=docker --vault-password-file=vault_pass`
* schedule auto run
* restart zabbix-agent `ansible linux -m command -a 'sudo systemctl restart zabbix-agent' --vault-password-file=vault_pass`

# Postgres
* create database `CREATE DATABASE <dbname>;`
* create user `CREATE USER <user> WITH ENCRYPTED PASSWORD '<password>';`
* grant user access `ALTER USER authelia WITH SUPERUSER;` ---scrap all to the right--`GRANT ALL PRIVILEGES ON DATABASE <dbname> TO <user>;` && `GRANT ALL PRIVILEGES ON ALL TABLES IN  SCHEMA public TO <user>;`&& `ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO <user>;`
* 
* `\c <dbname>` switch db
* `\dt` `\du`
## backup and restore

* backup -> `docker container exec Authelia-PG /usr/bin/pg_dump -U authelia authelia > authelia_test.sql`
* restore -> `psql -h zima -U <user> -d < script.sql` (make user and db available before hand)

# Packer

* `sudo act -j packer-ubuntu22-04-server  -r -v -P ubuntu-latest=catthehacker/ubuntu:act-latest --secret-file=../.secrets`

# Terraform

## act
* `sudo act -j terraform  -r -v -P ubuntu-latest=catthehacker/ubuntu:act-latest --secret-file=../.secrets`
* debuging `terraform state list` || `terraform destroy -target vsphere_virtual_machine.gh-runner -var-file=../../.secrets` || `terraform plan -var-file=../../.secrets`

## github runner
* just push

## Sanity rules

* don't update values that can restart vm if unintended, e.g (cpu, ram) (do it one vm at a time if needed)
* don't touch terraform managed resources in vcenter 

# Credits
* sam (terraform and packer template)
* monolithprojects.github_actions_runner (git runner role)
* k32-ansible (tech-tim)
* * forked the repo and added a subtree 
* * `git subtree add --prefix Ansible/k3s-ansible git@github.com:vcaster/k3s-ansible.git master --squash`
* * after commit push to the forked repo
* * `git subtree push --prefix Ansible/k3s-ansible git@github.com:vcaster/k3s-ansible.git master`
* Kubernetes heimdall (debontonline.com)
* Kubernetes vaultwarden https://github.com/icicimov/kubernetes-bitwarden_rs