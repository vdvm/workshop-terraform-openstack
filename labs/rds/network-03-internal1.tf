resource "openstack_networking_network_v2" "network_internal1" {
  name           = "${var.prefix}network-internal1"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_internal1" {
  name            = "${var.prefix}subnet-internal1"
  network_id      = "${openstack_networking_network_v2.network_internal1.id}"
  cidr            = "${var.subnet_internal1_cidr}"
  ip_version      = 4
  dns_nameservers = ["${var.primary_dns}", "${var.secondary_dns}"]
}

# data "openstack_networking_network_v2" "network_external" {
#   name = "${var.external_network_name}"
# }

# resource "openstack_networking_router_v2" "router_internal1_to_external" {
#   name                = "${var.prefix}router-internal1-to-external"
#   admin_state_up      = "true"
#   external_network_id = "${data.openstack_networking_network_v2.network_external.id}"
# }

# resource "openstack_networking_router_interface_v2" "router_interface_internal1" {
#   router_id = "${openstack_networking_router_v2.router_internal1_to_external.id}"
#   subnet_id = "${openstack_networking_subnet_v2.subnet_internal1.id}"
# }

resource "openstack_networking_router_interface_v2" "router_interface_internal1" {
  router_id = "${openstack_networking_router_v2.router_dmz_to_external.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet_internal1.id}"
}
