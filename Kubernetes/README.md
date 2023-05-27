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
* ALWAYS REMOVE NEWLINES WHEN CONVERTING TO B64 `echo -n 'zabbix' | base64`
* templates soon or never

# Certs

* add secrets
* create cert per namespace
* add domain to cert

# Monitoring

* deploy prometheus stack then loki
* kube api will 1000% hang if deployed at once

# Promethes manual fix
```
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.63.0/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagerconfigs.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.63.0/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.63.0/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.63.0/example/prometheus-operator-crd/monitoring.coreos.com_probes.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.63.0/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.63.0/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.63.0/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.63.0/example/prometheus-operator-crd/monitoring.coreos.com_thanosrulers.yaml
```

# Loki 

* add manual loki connection with `loki-stack.monitoring.svc.cluster.local:3100` to Grafana

# Zabbix

* for the agent configs
* * use the IPs of the worker nodes for the passive checks
* * use load balancer IP for serverActive and ensure hostname match 
* sanity check (edit zabbix active) agent.ping as passive (zabbix agent)
* setup auto registration with hostmetadata (see ansible)
* enable discovery on local network

# Longhorn

* create a nfs share with nobody as its user (OPEN -> acl)
* may mess things up with kubernetes

# Maintenance

* drain node 
* `kubectl drain <node-name> --delete-local-data --ignore-daemonsets --force`