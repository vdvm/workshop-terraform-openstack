variable "prefix" {
  default = "lamp-"
}

variable "subnet_internal_cidr" {
  default = "192.168.42.0/24"
}

variable "vip_address" {
  default = "192.168.42.42"
}

variable "primary_dns" {
  default = "8.8.8.8"
}

variable "secondary_dns" {
  default = "8.8.4.4"
}

variable "instance_count" {
  type = "map"

  default = {
    "web" = 2
    "db"  = 0
  }
}
