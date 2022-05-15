module "splunk-cluster-master-spb-linuxvm" {
  providers = {
    vsphere = vsphere.spb
  }
  source           = "Terraform-VMWare-Modules/vm/vsphere"
  version          = "3.1.0"
  dc               = "SPB-Datacenter"
  vmrp             = "/SPB-Datacenter/host/vSAN Cluster/Resources"
  vmfolder         = "CT/CT21"
  is_windows_image = false
  vmtemp           = "tpl-centos8"
  firmware         = "efi"
  instances        = 1
  cpu_number       = 1
  ram_size         = 1024
  vmname           = "spb-srv-ct21-cm"
  domain           = "example.com"
  network = {
    "Customer21 Network" = ["10.1.21.10"]
  }
  ipv4submask     = ["24"]
  network_type    = ["vmxnet3"]
  dns_server_list = ["10.1.250.10", "10.1.250.10"]
  vmgateway       = "10.1.21.1"
  tags = {
    "terraform-category" = "terraform-tag"
    "env"                = "production"
    "role"               = "splunk-cluster-master"
  }
}

module "splunk-indexer-spb-linuxvm" {
  providers = {
    vsphere = vsphere.spb
  }
  source           = "Terraform-VMWare-Modules/vm/vsphere"
  version          = "3.1.0"
  dc               = "SPB-Datacenter"
  vmrp             = "/SPB-Datacenter/host/vSAN Cluster/Resources"
  vmfolder         = "CT/CT21"
  is_windows_image = false
  vmtemp           = "tpl-centos8"
  firmware         = "efi"
  instances        = 2
  cpu_number       = 16
  ram_size         = 32768
  vmname           = "spb-srv-ct21-idx"
  domain           = "example.com"
  network = {
    "Customer21 Network" = ["10.1.21.20", "10.1.21.21"]
  }
  ipv4submask     = ["24"]
  network_type    = ["vmxnet3"]
  dns_server_list = ["10.1.250.10", "10.1.250.10"]
  vmgateway       = "10.1.21.1"
  tags = {
    "terraform-category" = "terraform-tag"
    "env"                = "production"
    "role"               = "splunk-indexer"
  }
  data_disk = {
    hot_disk = {
      size_gb                   = 2000,
      thin_provisioned          = false,
      data_disk_scsi_controller = 0,
      datastore_id              = "datastore-1"
    }
    frozen_disk = {
      size_gb                   = 3000,
      thin_provisioned          = false,
      data_disk_scsi_controller = 0,
      datastore_id              = "datastore-2"
    }
  }
  scsi_bus_sharing = "physicalSharing"
  scsi_type        = "pvscsi"
  scsi_controller  = 0
  enable_disk_uuid = true
}

module "splunk-searchhead-spb-linuxvm" {
  providers = {
    vsphere = vsphere.spb
  }
  source           = "Terraform-VMWare-Modules/vm/vsphere"
  version          = "3.1.0"
  dc               = "SPB-Datacenter"
  vmrp             = "/SPB-Datacenter/host/vSAN Cluster/Resources"
  vmfolder         = "CT/CT21"
  is_windows_image = false
  vmtemp           = "tpl-centos8"
  firmware         = "efi"
  instances        = 3
  cpu_number       = 8
  ram_size         = 16384
  vmname           = "spb-srv-ct21-sh"
  domain           = "example.com"
  network = {
    "Customer21 Network" = ["10.1.21.30", "10.1.21.31", "10.1.21.32"]
  }
  ipv4submask     = ["24"]
  network_type    = ["vmxnet3"]
  dns_server_list = ["10.1.250.10", "10.1.250.10"]
  vmgateway       = "10.1.21.1"
  tags = {
    "terraform-category" = "terraform-tag"
    "env"                = "production"
    "role"               = "splunk-searchhead"
  }
}

module "splunk-heavy-forwarder-spb-linuxvm" {
  providers = {
    vsphere = vsphere.spb
  }
  source           = "Terraform-VMWare-Modules/vm/vsphere"
  version          = "3.1.0"
  dc               = "SPB-Datacenter"
  vmrp             = "/SPB-Datacenter/host/vSAN Cluster/Resources"
  vmfolder         = "CT/CT21"
  is_windows_image = false
  vmtemp           = "tpl-centos8"
  firmware         = "efi"
  instances        = 2
  cpu_number       = 8
  ram_size         = 16384
  vmname           = "spb-srv-ct21-hf"
  domain           = "example.com"
  network = {
    "Customer21 Network" = ["10.1.21.40", "10.1.21.41"]
  }
  ipv4submask     = ["24"]
  network_type    = ["vmxnet3"]
  dns_server_list = ["10.1.250.10", "10.1.250.10"]
  vmgateway       = "10.1.21.1"
  tags = {
    "terraform-category" = "terraform-tag"
    "env"                = "production"
    "role"               = "splunk-heavy-forwarder"
  }
}
