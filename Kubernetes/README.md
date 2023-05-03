# Install

* manual deploy from github

# Debug

* flux logs `flux logs --follow --level=error --all-namespaces`

# Ingress

* remove changed ingress before pushing updates

# Authelia Ingress

* specify policy in configmap
* add the ingress to `ingress-config.yml` or create 

# Secrets

* secrets with sensitive files are stored in a different repo
* templates soon or never

# Certs

* add secrets
* create cert per namespace
* add domain to cert