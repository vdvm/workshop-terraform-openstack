resource "openstack_compute_instance_v2" "rdg" {
  count             = "${var.instance_count["rdg"]}"
  name              = "${var.prefix}rdg${count.index}"
  availability_zone = "${element(var.availability_zones, count.index % length(var.availability_zones))}"
  image_name        = "${var.instance_image["windows"]}"
  flavor_name       = "${var.instance_flavor["windows_small"]}"
  key_pair          = "${var.prefix}keypair"
  security_groups   = ["default", "allow-all"]

  network {
    name = "${openstack_networking_network_v2.network_dmz.name}"
  }
}
