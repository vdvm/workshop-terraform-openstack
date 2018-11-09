variable "external_network_name" {
  default = "floating"
}

variable "secgroup_default_name" {
  default = "default"
}

variable "availability_zones" {
  default = ["AMS-EQ1", "AMS-EQ3", "AMS-EU4"]
}

variable "instance_image" {
  type = "map"

  default = {
    "linux"   = "Ubuntu 18.04 (LTS)"
    "windows" = "Windows Server 2016 Standard"
  }
}

variable "instance_flavor" {
  type = "map"

  default = {
    "linux_small"   = "Small HD 2GB"
    "windows_small" = "Medium HD 4GB"
  }
}
