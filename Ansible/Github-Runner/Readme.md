# Install

* remove existing runners from github
* `ansible-galaxy install monolithprojects.github_actions_runner`
* edit name and add token (all repo access) to `~/.ansible/roles/monolithprojects.github_actions_runner/defaults/main.yml `
* debug `systemctl status actions.runner.vcaster-Homelab.gh-runner` or `journalctl -fu actions.runner.vcaster-Homelab.gh-runner`
```
sudo apt install nodejs
sudo ln -s /usr/bin/nodejs /usr/local/bin/node   
```

# Run 

* `ansible-playbook -i inventory install.yml`