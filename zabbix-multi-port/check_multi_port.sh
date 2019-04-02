#!/bin/bash

##### LIST PORT HERE:
list_port="127.0.0.1;8881;Loi_Connect_toi_OS1
localhost;8882;Loi_Connect_toi_OS2
localhost;8883;Loi_Connect_toi_OS3
192.168.80.12;8888;Loi_Connect_toi_OS4"






########################################## CHECK
path_log="/tmp/check_multi_port.log"
path_log2="/tmp/check_multi_port.log2"
cat /dev/null > ${path_log}
cat /dev/null > ${path_log2}

#function
check_port() {
status_port=`/etc/zabbix/scripts/check_tcp -H ${1} -p ${2} -t 1`
echo "$1|$2|$3|$status_port|" >> ${path_log}
echo "$1|$2|$3|$status_port|" | grep -v "TCP OK" >> ${path_log2}
}

#check
for i in ${list_port}
do
 ip=`echo ${i} | awk -F ';' '{print $1}'`
 port=`echo ${i} | awk -F ';' '{print $2}'`
 response=`echo ${i} | awk -F ';' '{print $3}'`
 check_port ${ip} ${port} ${response}
done 



#report 
count=`cat $path_log | grep -v "TCP OK" | wc -l`
z=1
if [ $count -gt 0 ]
then
  while [ $z -le $count ]
  do
    ip_report=`cat ${path_log2} | sed -n ${z}p | awk -F '|' '{print $1}'`
    port_report=`cat ${path_log2} |sed -n ${z}p | awk -F '|' '{print $2}'`
    response_report=`cat ${path_log2} | sed -n ${z}p | awk -F '|' '{print $3}'`
    z=`expr $z + 1`
    echo $response_report IP: ${ip_report}:${port_report} 
  done
else
  echo 0
fi
