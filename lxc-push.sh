#!/bin/bash
# Attach/Remove disk from array file pairs
# Usage:
#    command [add/remove] [disk_device.list] [lxd_container.list]

lxd_TOTAL=6
do_ACTION=$1

lxd_LIST=$2
file_DIR=$3

file_DIR=0
lxd_COUNT=0

count_STAT=0
count_STOP=$(($lxd_TOTAL + 1 ))

# Counter
add_count () {
    count_OSD=$(($count_OSD + 1))
    count_NVME=$(($count_NVME + 1))
    count_STAT=$(($count_STAT + 1))
}

next_nvme () {
    on_NVME=$(tail -n+$count_NVME $nvme_LIST | head -n1)
}

next_osd () {
    on_OSD=$(tail -n+$count_OSD $lxd_LIST | head -n1)
}

attach_main () {
    add_count
    while [[ $count_STAT -lt $count_STOP ]]; do
        next_nvme
        next_osd
        echo "Adding $on_NVME to $on_OSD"
        lxc file $do_ACTION \
            $on_OSD $on_NVME disk \
            source=/dev/$on_NVME  \
            path=/dev/$on_NVME
        echo "Done ..."
        add_count
    done
}

attach_main
