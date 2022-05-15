terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.0.2"
    }
  }
}

provider "vsphere" {
  alias                = "msk"
  user                 = "username@vsphere.local"
  password             = "password"
  vsphere_server       = "1.2.3.4"
  allow_unverified_ssl = true
}

provider "vsphere" {
  alias                = "spb"
  user                 = "username@vsphere.local"
  password             = "password"
  vsphere_server       = "5.6.7.8"
  allow_unverified_ssl = true
}
