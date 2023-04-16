# Kinda dumped for github actions

# Install ansibe

* `python3 -m pip install ansible`

# Run

* Make sure the box is available
* `ansible-playbook -i inventory playbook.yaml`

# Docker

* ssh in
* `docker container exec -it jenkins /bin/bash`
* `cat /var/jenkins_home/secrets/initialAdminPassword`