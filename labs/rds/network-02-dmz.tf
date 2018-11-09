resource "openstack_networking_network_v2" "network_dmz" {
  name           = "${var.prefix}network-dmz"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_dmz" {
  name            = "${var.prefix}subnet-dmz"
  network_id      = "${openstack_networking_network_v2.network_dmz.id}"
  cidr            = "${var.subnet_dmz_cidr}"
  ip_version      = 4
  dns_nameservers = ["${var.primary_dns}", "${var.secondary_dns}"]
}

# data "openstack_networking_network_v2" "network_external" {
#   name = "${var.external_network_name}"
# }

resource "openstack_networking_router_v2" "router_dmz_to_external" {
  name                = "${var.prefix}router-dmz-to-external"
  admin_state_up      = "true"
  external_network_id = "${data.openstack_networking_network_v2.network_external.id}"
}

resource "openstack_networking_router_interface_v2" "router_interface_dmz" {
  router_id = "${openstack_networking_router_v2.router_dmz_to_external.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet_dmz.id}"
}
