#!/bin/bash
# For Loop Tool - Batch Execute on LXD
# Usage:
#    [command] [node-list.file] [starting_IP_ADDR] [subnet_mask]

node_LIST="$1"
start_IP_ADDR="$2"
ip_MASK="$3"

calc_ipaddr () {
ip_ADDR_ALLOC=$(($ip_INET_ADDR + 1))
}

for lxd_NODE in $(cat $nodes_LIST); do
    iface_COUNTER="0"
    for lxd_IFACE in $(lxc config device list | grep "ceph"); do
        if [[ $iface_COUNTER -eq 0 ]]; then
            echo "Skipping $lxd_IFACE first DHCP configured interface"
            iface_COUNTER=$(($iface_COUNTER + 1))
        elif [[ $iface_COUNTER -eq 0 ]]; then
            ifcfg $lxd_NODE $lxd_IFACE $ip_ADDR_ALLOC $ip_MASK
            calc_ipaddr
        fi
    done
done

