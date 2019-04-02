#!/bin/sh


list="3;tomcat7;1
3;HelloWorld.jar;1
4;redis-server;6379;1"

##################################### CHECK
cat /dev/null > /tmp/count_tmp.log

for i in $list
do
 step=`echo $i | awk -F ";" '{print $1}'`

 if [ $step -eq 3 ]
  then
   service_1=`echo $i | awk -F ";" '{print $2}'`
   prefix_count=`echo $i | awk -F ";" '{print $3}'`
   count=`ps aux | grep $service_1 | grep -v grep | wc -l`
   echo "$count;$prefix_count;$service_1" >> /tmp/count_tmp.log
 elif [ $step -eq 4 ]
  then
   service_1=`echo $i | awk -F ";" '{print $2}'`
   service_2=`echo $i | awk -F ";" '{print $3}'`
   prefix_count=`echo $i | awk -F ";" '{print $4}'`
   count=`ps aux | grep $service_1 | grep -v grep | grep $service_2 | wc -l`
   echo "$count;$prefix_count;$service_1" >> /tmp/count_tmp.log
 fi

done

for y in `cat /tmp/count_tmp.log`
 do 
  running=`echo $y | awk -F ";" '{print $1}'`
  prefix_running=`echo $y | awk -F ";" '{print $2}'`
  name=`echo $y | awk -F ";" '{print $3}'`
  if [ $running -eq $prefix_running ]
   then
   #disable echo to compact report.
   #echo "NORMAL - Service $name running"
   test="1"
  else 
   echo "CRITICAL - Service $name stopped. $running #diff $prefix_running "
  fi
 done
 

