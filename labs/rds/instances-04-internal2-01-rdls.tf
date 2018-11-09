resource "openstack_compute_instance_v2" "rdls" {
  count             = "${var.instance_count["rdls"]}"
  name              = "${var.prefix}rdls${count.index}"
  availability_zone = "${element(var.availability_zones, count.index % length(var.availability_zones))}"
  image_name        = "${var.instance_image["windows"]}"
  flavor_name       = "${var.instance_flavor["windows_small"]}"
  key_pair          = "${var.prefix}keypair"
  security_groups   = ["default", "allow-all"]

  network {
    name = "${openstack_networking_network_v2.network_internal2.name}"
  }
}
