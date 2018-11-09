resource "openstack_networking_secgroup_v2" "secgroup_db" {
  name        = "${var.prefix}db"
  description = "My database server security group"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_db_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  port_range_min    = 0
  port_range_max    = 0
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_db.id}"
  depends_on        = ["openstack_networking_secgroup_v2.secgroup_db"]
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_db_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_db.id}"
  depends_on        = ["openstack_networking_secgroup_rule_v2.secgroup_db_rule_1"]
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_db_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3306
  port_range_max    = 3306
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_db.id}"
  depends_on        = ["openstack_networking_secgroup_rule_v2.secgroup_db_rule_2"]
}
