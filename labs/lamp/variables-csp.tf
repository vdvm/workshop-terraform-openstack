variable "external_network_name" {
  default = "floating"
}

variable "availability_zones" {
  default = ["AMS-EQ1", "AMS-EQ3", "AMS-EU4"]
}

variable "instance_image" {
  type = "map"

  default = {
    "linux"   = "Ubuntu 18.04 (LTS)"
  }
}

variable "instance_flavor" {
  type = "map"

  default = {
    "small"  = "Small HD 2GB"
    "medium" = "Small HD 4GB"
  }
}
