resource "openstack_networking_network_v2" "network_internal2" {
  name           = "${var.prefix}network-internal2"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_internal2" {
  name            = "${var.prefix}subnet-internal2"
  network_id      = "${openstack_networking_network_v2.network_internal2.id}"
  cidr            = "${var.subnet_internal2_cidr}"
  ip_version      = 4
  dns_nameservers = ["${var.primary_dns}", "${var.secondary_dns}"]
}

# data "openstack_networking_network_v2" "network_external" {
#   name = "${var.external_network_name}"
# }

# resource "openstack_networking_router_v2" "router_internal2_to_external" {
#   name                = "${var.prefix}router-internal2-to-external"
#   admin_state_up      = "true"
#   external_network_id = "${data.openstack_networking_network_v2.network_external.id}"
# }

# resource "openstack_networking_router_interface_v2" "router_interface_internal2" {
#   router_id = "${openstack_networking_router_v2.router_internal2_to_external.id}"
#   subnet_id = "${openstack_networking_subnet_v2.subnet_internal2.id}"
# }

resource "openstack_networking_router_interface_v2" "router_interface_internal2" {
  router_id = "${openstack_networking_router_v2.router_dmz_to_external.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet_internal2.id}"
}
