resource "openstack_lb_loadbalancer_v2" "lb_1" {
  vip_subnet_id      = "${openstack_networking_subnet_v2.subnet_internal.id}"
  vip_address        = "${var.vip_address}"
  security_group_ids = ["${openstack_networking_secgroup_v2.secgroup_lb.id}"]
}

resource "openstack_lb_listener_v2" "listener_1" {
  protocol        = "HTTP"
  protocol_port   = 80
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.lb_1.id}"
}

resource "openstack_lb_pool_v2" "pool_1" {
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"
  listener_id = "${openstack_lb_listener_v2.listener_1.id}"
}

resource "openstack_lb_member_v2" "members_1" {
  depends_on    = ["openstack_compute_instance_v2.web"]
  count         = "${var.instance_count["web"]}"
  address       = "${element(openstack_compute_instance_v2.web.*.access_ip_v4, count.index)}"
  protocol_port = 80
  pool_id       = "${openstack_lb_pool_v2.pool_1.id}"
  subnet_id     = "${openstack_networking_subnet_v2.subnet_internal.id}"
}

resource "openstack_lb_monitor_v2" "monitor_1" {
  depends_on  = ["openstack_lb_member_v2.members_1"]
  pool_id     = "${openstack_lb_pool_v2.pool_1.id}"
  type        = "PING"
  delay       = 20
  timeout     = 10
  max_retries = 5
}

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "${var.external_network_name}"
}

resource "openstack_networking_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
  port_id     = "${openstack_lb_loadbalancer_v2.lb_1.vip_port_id}"
}
