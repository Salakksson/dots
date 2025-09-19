#!/usr/bin/env bash

SUDO=""

if [ "$EUID" -ne 0 ]
then
	SUDO=sudo
fi

NET_DIR=/sys/class/net

declare -a devices

device_count=0

echo "choose a device:"
for dev in $NET_DIR/*;
do
	dev=$(basename $dev)
	ip=$($SUDO ip -o -f inet addr show $dev | awk '{print $4}')
	echo -e "    $((device_count+1)) → $dev: $ip"
	devices[$device_count]=$dev
	device_count=$((++device_count))
done

printf "enter number: "

read i

DEV=${devices[$((i-1))]}

echo "selected device: $DEV"

ip=$($SUDO ip -o -f inet addr show $dev | awk '{print $4}')

IP=${ip%/*}
MASK=${ip#*/}

case "$MASK" in
	8)
		subnet="$(echo "$ip" | cut -d. -f1)."
		;;
	16)
		subnet="$(echo "$ip" | cut -d. -f1-2)."
		;;
	24)
		subnet="$(echo "$ip" | cut -d. -f1-3)."
		;;
	*)
		subnet=""
		;;
esac

printf "enter new ip address: $subnet"
read addr
IP="$subnet$addr"

echo "changing ip to: $IP"

$SUDO ip addr flush dev $DEV
$SUDO ip addr add $IP/$MASK dev $DEV
$SUDO ip link set $DEV up
