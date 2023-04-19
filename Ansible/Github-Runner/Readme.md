# Install

* remove existing runners from github
* `ansible-galaxy install monolithprojects.github_actions_runner`
* edit name and add token (all repo access) to `~/.ansible/roles/monolithprojects.github_actions_runner/defaults/main.yml `
* debug `systemctl status actions.runner.vcaster-Homelab.gh-runner` or `journalctl -fu actions.runner.vcaster-Homelab.gh-runner`
* the  `Forbidden-Fruit` ref is a dir with ssh and gpg keys with repo access

# Run 

* `ansible-playbook -i inventory install.yml`