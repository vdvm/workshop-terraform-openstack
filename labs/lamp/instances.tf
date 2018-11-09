resource "openstack_compute_instance_v2" "web" {
  count             = "${var.instance_count["web"]}"
  name              = "${var.prefix}web${count.index}"
  availability_zone = "${element(var.availability_zones, count.index % length(var.availability_zones))}"
  image_name        = "${var.instance_image["linux"]}"
  flavor_name       = "${var.instance_flavor["small"]}"
  key_pair          = "${var.prefix}keypair"
  security_groups   = ["default", "${openstack_networking_secgroup_v2.secgroup_web.name}"]
  user_data         = "${file("bootstrap.sh")}"

  network {
    name = "${openstack_networking_network_v2.network_internal.name}"
  }
}

resource "openstack_compute_instance_v2" "db" {
  count             = "${var.instance_count["db"]}"
  name              = "${var.prefix}db${count.index}"
  availability_zone = "${element(var.availability_zones, count.index % length(var.availability_zones))}"
  image_name        = "${var.instance_image["linux"]}"
  flavor_name       = "${var.instance_flavor["medium"]}"
  key_pair          = "${var.prefix}keypair"
  security_groups   = ["default", "${openstack_networking_secgroup_v2.secgroup_db.name}"]

  network {
    name = "${openstack_networking_network_v2.network_internal.name}"
  }
}
