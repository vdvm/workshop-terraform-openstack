data "openstack_networking_network_v2" "network_external" {
  name = "${var.external_network_name}"
}
