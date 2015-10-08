#!/bin/bash 

. /aws.sh

isAWS=$(aws_is_amazon)

if [ $isAWS = "true" ]
then
    ip=$(aws_get_private_ipv4)
else
    ip=`ifconfig | awk '/inet addr/{print substr($2,6)}' | head -1`
fi

/usr/local/bin/etcd --data-dir=/var/etcd -listen-peer-urls "http://$ip:4001"
