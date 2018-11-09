resource "openstack_networking_secgroup_v2" "secgroup_web" {
  name        = "${var.prefix}web"
  description = "My web server security group"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_web_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  port_range_min    = 0
  port_range_max    = 0
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_web.id}"
  depends_on        = ["openstack_networking_secgroup_v2.secgroup_web"]
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_web_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_web.id}"
  depends_on        = ["openstack_networking_secgroup_rule_v2.secgroup_web_rule_1"]
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_web_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_web.id}"
  depends_on        = ["openstack_networking_secgroup_rule_v2.secgroup_web_rule_2"]
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_web_rule_4" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_web.id}"
  depends_on        = ["openstack_networking_secgroup_rule_v2.secgroup_web_rule_3"]
}
