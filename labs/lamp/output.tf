output "floatingip.address" {
  value = "${openstack_networking_floatingip_v2.fip_1.address}"
}
