#!/bin/bash

HOST=$1
PORT=$2

echo $1 $2 >> /tmp/tuan111.txt

check=`/etc/zabbix/scripts/check_icmp -H ${HOST} -n 1 | grep "OK" | wc -l`


if [ ${check} -ne 1 ]
 then
  echo 0
 else
  echo 1
fi

