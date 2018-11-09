resource "openstack_compute_instance_v2" "lb" {
  count             = "${var.instance_count["lb"]}"
  name              = "${var.prefix}lb${count.index}"
  availability_zone = "${element(var.availability_zones, count.index % length(var.availability_zones))}"
  image_name        = "${var.instance_image["linux"]}"
  flavor_name       = "${var.instance_flavor["linux_small"]}"
  key_pair          = "${var.prefix}keypair"
  # security_groups   = ["default", "allow-all"]

  network {
    name = "${openstack_networking_network_v2.network_dmz.name}"
    port = "${element(openstack_networking_port_v2.port_lb.*.id, count.index)}"
  }

  metadata {
    ha_vip_address = "${openstack_networking_port_v2.port_vip.fixed_ip.0.ip_address}"
    ha_floatingips = "${openstack_networking_floatingip_v2.fip_1.address}"
    ha_execution   = "1"

    # # Ansible inventory
    # keepalived.notification_email = "someone@example.com"
    # keepalived.pass   = "${random_string.secret1.result}"
    # keepalived.intvip = "${openstack_networking_port_v2.port_vip.fixed_ip.0.ip_address}"
    # keepalived.intnic = "eth0"
  }

  depends_on = [
    "openstack_networking_network_v2.network_dmz",
    "openstack_networking_port_v2.port_lb"
  ]
}

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "${var.external_network_name}"
}

# resource "openstack_compute_floatingip_associate_v2" "fip_1" {
#   floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
#   instance_id = "${openstack_compute_instance_v2.instance_xyz.id}"
# }
