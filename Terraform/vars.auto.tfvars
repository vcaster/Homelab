cpu                    = 4
cores-per-socket       = 1
ram                    = 4096
disksize               = 100 # in GB
vm-guest-id            = "ubuntu64Guest"
vsphere-unverified-ssl = "true"
vsphere-datacenter     = "Datacenter"
vsphere-cluster        = "Patron Cluster"
vm-datastore           = "vsanDatastore"
vm-network             = "VDS Net"
vm-domain              = "patron.boss"
dns_server_list        = ["10.10.10.51", "10.10.10.1"]
ipv4_gateway           = "10.10.10.1"
ipv4_netmask           = "16"


ubuntu22-04-test                = "ubuntu22-04-test"
ubuntu22-04-test-ipv4_address   = "10.10.2.2"
ubuntu2204-server-template-name = "Ubuntu-2204-Template-100GB-Thin"

gh-runner                = "gh-runner"
gh-runner-ipv4_address   = "10.10.2.3"

kubernetes = [
    {
        name = "padre-01"
        cpus = 4
        cores_per_socket = 1
        ram = 4096
        disk_size = 100
        ip_addr = "10.10.5.1"
    },
    {
        name = "padre-02"
        cpus = 4
        cores_per_socket = 1
        ram = 2048
        disk_size = 100
        ip_addr = "10.10.5.2"
    },
    {
        name = "padre-03"
        cpus = 4
        cores_per_socket = 1
        ram = 2048
        disk_size = 100
        ip_addr = "10.10.5.3"
    },
    {
        name = "sicario-01"
        cpus = 8
        cores_per_socket = 2
        ram = 16384
        disk_size = 151
        ip_addr = "10.10.5.11"
    },
    {
        name = "sicario-02"
        cpus = 8
        cores_per_socket = 2
        ram = 16384
        disk_size = 150
        ip_addr = "10.10.5.12"
    },
    {
        name = "sicario-03"
        cpus = 8
        cores_per_socket = 2
        ram = 16384
        disk_size = 150
        ip_addr = "10.10.5.13"
    },
    {
        name = "sicario-04"
        cpus = 8
        cores_per_socket = 2
        ram = 16384
        disk_size = 150
        ip_addr = "10.10.5.14"
    }
]