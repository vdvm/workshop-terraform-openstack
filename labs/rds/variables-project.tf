variable "prefix" { default = "rds-" }

variable "subnet_dmz_cidr"       { default = "172.16.1.0/24" }
variable "subnet_internal1_cidr" { default = "10.0.1.0/24" }
variable "subnet_internal2_cidr" { default = "10.0.2.0/24" }

variable "primary_dns"   { default = "8.8.8.8" }
variable "secondary_dns" { default = "8.8.4.4" }

variable "vip_address" { default = "172.16.1.42"}

variable "instance_count" {
  type = "map"

  default = {
    "lb"   = 3 # Load Balancer (3x)
    "rdwa" = 0 # Web Access (3x)
    "rdg"  = 0 # Gateway

    "rdcb" = 0 # Connection Broker (3x)
    "rdsh" = 0 # Session Host (6x)
    "rdvh" = 0 # Virtualization Host

    "rdls" = 0 # RD License Server (2x)
    "addc" = 0 # Domain Services (3x)
    "fs"   = 0 # File Services (3x)
    "sql"  = 0 # Database Services (2x)
  }
}
