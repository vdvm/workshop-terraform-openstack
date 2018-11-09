# README: Load Balancing as a Service (LBaaS)

## Diagram

![lbaasv2-diagram](lbaasv2-diagram.png "LBaaS v2 diagram")

## Configure

Create a load balancer:

```
neutron lbaas-loadbalancer-create --name <LB-NAME> --vip-address <VIP-ADDRESS> \
<PRIVATE-SUBNET-NAME>
```

Create an HTTP listener:

```
neutron lbaas-listener-create --name <LISTENER-NAME> --loadbalancer <LB-NAME> \
--protocol HTTP --protocol-port 80
```

Create a LBaaS pool that will be used as default for LISTENER-NAME:

```
neutron lbaas-pool-create --name <POOL-NAME> --lb-algorithm ROUND_ROBIN \
--listener <LISTENER-NAME> --protocol HTTP
```

Create a health monitor that ensures health of the pool's members:

```
neutron lbaas-healthmonitor-create --name <HM-NAME> --delay 5 --timeout 3 \
--max-retries 4 --type HTTP --pool <POOL-NAME>
```

Add back end servers to the pool:

```
neutron lbaas-member-create --name <MEMBER1-NAME> --subnet <PRIVATE-SUBNET-NAME> \
--address <SERVER1-IP> --protocol-port 80 <POOL-NAME>
neutron lbaas-member-create --name <MEMBER2-NAME> --subnet <PRIVATE-SUBNET-NAME> \
--address <SERVER2-IP> --protocol-port 80 <POOL-NAME>
```

Create a floating IP address in a public network and associate it with a port of load balancer's VIP:

```
vip_port_id=$(neutron lbaas-loadbalancer-show <LB-NAME> -c vip_port_id -f value)
fip_id=$(neutron floatingip-create <EXTERNAL-NETWORK-NAME> -c id -f value | head -1)
neutron floatingip-associate $fip_id $vip_port_id
```

Attach a security group to the VIP port:

```
neutron port-update --security-group allow-all $vip_port_id
```

## Resources

- https://docs.mirantis.com/mcp/latest/mcp-deployment-guide/configure-octavia/example-lb-topology.html
- https://wiki.openstack.org/wiki/Neutron/LBaaS/HowToRun#Topology_Setup
- https://docs.openstack.org/mitaka/networking-guide/config-lbaas.html
- https://www.cloudvps.nl/openstack/lbaas-met-een-ha-ip-en-automatische-failover
