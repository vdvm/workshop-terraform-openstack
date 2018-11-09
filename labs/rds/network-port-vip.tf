resource "openstack_networking_port_v2" "port_vip" {
  name               = "${var.prefix}port-vip"
  network_id         = "${openstack_networking_network_v2.network_dmz.id}"
  security_group_ids = [
    "${data.openstack_networking_secgroup_v2.secgroup_default.id}",
    "${openstack_networking_secgroup_v2.secgroup_public.id}"
  ]
  admin_state_up     = "true"

  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_dmz.id}"
    "ip_address" = "${var.vip_address}"
  }
}
