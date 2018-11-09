resource "openstack_compute_instance_v2" "rdvh" {
  count             = "${var.instance_count["rdvh"]}"
  name              = "${var.prefix}rdvh${count.index}"
  availability_zone = "${element(var.availability_zones, count.index % length(var.availability_zones))}"
  image_name        = "${var.instance_image["windows"]}"
  flavor_name       = "${var.instance_flavor["windows_small"]}"
  key_pair          = "${var.prefix}keypair"
  security_groups   = ["default", "allow-all"]

  network {
    name = "${openstack_networking_network_v2.network_internal1.name}"
  }
}
