#!/bin/bash

container_name="$1"
ceph_iface_maas="$2"
ceph_iface_mgmt="$3"
ceph_iface_osd="$4"

iface_NAME="ceph"

lxc launch ubuntu: $container_name
obb --add-port maas $iface_NAME$ceph_iface_maas $container_name
lxc restart $container_name 
lxc exec $container_name -- /bin/bash -c \
    "useradd -d /home/cadmin -m cadmin -p cephmaster"
lxc exec $container_name -- /bin/bash -c "mkdir -p /home/cadmin/.ssh"
obb --add-port ceph-mgmt $iface_NAME$ceph_iface_mgmt $container_name
obb --add-port ceph-osd $iface_NAME$ceph_iface_osd $container_name

lxc file push ceph-ssh/authorized_keys $container_name/home/cadmin/.ssh/
lxc file push ceph-prep.sh $container_name/root/
lxc exec $container_name -- /bin/bash -c "/root/ceph-prep.sh"
#lxc config edit $container_name 
