resource "openstack_networking_port_v2" "port_lb" {
  count              = "${var.instance_count["lb"]}"
  name               = "${var.prefix}lb${count.index}-port"
  network_id         = "${openstack_networking_network_v2.network_dmz.id}"
  security_group_ids = [
    "${data.openstack_networking_secgroup_v2.secgroup_default.id}",
    "${openstack_networking_secgroup_v2.secgroup_public.id}"
  ]
  admin_state_up    = "true"

  fixed_ip {
    "subnet_id" = "${openstack_networking_subnet_v2.subnet_dmz.id}"
  }

  allowed_address_pairs {
    ip_address = "${openstack_networking_port_v2.port_vip.fixed_ip.0.ip_address}"
  }
}
