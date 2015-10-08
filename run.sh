#!/bin/bash 

. /aws.sh

isAWS=$(aws_is_amazon)

if [ $isAWS = "true" ]
then
    ip=$(aws_get_private_ipv4)
else
    ip=`ifconfig | awk '/inet addr/{print substr($2,6)}' | head -1`
fi

/usr/local/bin/etcd \
	--data-dir=/var/etcd \
	-name etcd0 \
	-advertise-client-urls http://${ip}:2379,http://${ip}:4001 \
	-listen-client-urls "http://0.0.0.0:2379,http://0.0.0.0:4001" \
	-initial-advertise-peer-urls http://${ip}:2380 \
	-listen-peer-urls http://0.0.0.0:2380 \
	-initial-cluster-token etcd-cluster-1 \
	-initial-cluster etcd0=http://${ip}:2380 \
	-initial-cluster-state new

