resource "openstack_networking_secgroup_v2" "secgroup_lb" {
  name        = "${var.prefix}lb"
  description = "My loadbalancer security group"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_lb_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  port_range_min    = 0
  port_range_max    = 0
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_lb.id}"
  depends_on        = ["openstack_networking_secgroup_v2.secgroup_lb"]
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_lb_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_lb.id}"
  depends_on        = ["openstack_networking_secgroup_rule_v2.secgroup_lb_rule_1"]
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_lb_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_lb.id}"
  depends_on        = ["openstack_networking_secgroup_rule_v2.secgroup_lb_rule_2"]
}
