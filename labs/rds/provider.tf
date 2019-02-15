terraform {
  required_version = "> 0.11.7, < 0.12.0"
}

provider "openstack" {
  version = "= 1.14"
}

provider "random" {
  version = "~> 2.0"
}
