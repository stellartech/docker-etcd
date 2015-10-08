#!/bin/bash

function aws_is_amazon {
  grep compute.internal /etc/resolv.conf > /dev/null &&  echo "true" || echo "false"
}

function aws_get_region {
  curl -L http://169.254.169.254/latest/dynamic/instance-identity/document 2> /dev/null |grep region|awk -F\" '{print $4}'
}

function aws_get_private_ipv4 {
  curl -L http://169.254.169.254/latest/meta-data/local-ipv4 2> /dev/null
}

function aws_get_public_dns {
  curl -L http://169.254.169.254/latest/meta-data/public-hostname 2> /dev/null
}

function aws_get_public_hostname {
  aws_get_public_dns | cut -d "." -f -2
}

function aws_get_instance_id {
  curl -L http://169.254.169.254/latest/meta-data/instance-id 2> /dev/null
}

function aws_get_hostname {
  curl -L http://169.254.169.254/latest/meta-data/hostname 2> /dev/null
}

function aws_get_short_hostname {
  aws_get_hostname | cut -d "." -f -2
}

