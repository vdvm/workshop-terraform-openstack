data "openstack_networking_secgroup_v2" "secgroup_default" {
  name = "${var.secgroup_default_name}"
}
