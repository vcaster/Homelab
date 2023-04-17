##################################################################################
# VARIABLES
##################################################################################

# vSphere Objects

vcenter_insecure_connection     = true
vcenter_server                  = "vcenter.patron.boss"
vcenter_datacenter              = "Datacenter"
vcenter_host                    = "esxi-02.patron.boss"
vcenter_datastore               = "vsanDatastore"
vcenter_network                 = "VDS Net"
vcenter_folder                  = "Templates"

# ISO Objects
iso_url                         = "http://nas.patron.boss:8080/Public/ISOs/59440f64-3ade-d0f7-a336-c81f66ce4482/ubuntu-22.04.1-live-server-amd64.iso" 
iso_path                        = "[vsanDatastore] /packer_cache/ubuntu-22.04.3-live-server-amd64.iso"
