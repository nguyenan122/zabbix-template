1. Import template to zabbix (version >3)

2. Setting zabbix_agent
```
# yum install ntpdate (Centos)
# apt-get install ntpdate  (Ubuntu)
```
```
vim /etc/zabbix/zabbix_agentd.d/userparameter_time.conf

UserParameter=time.drift[*],if [ -f /var/lib/ntp/drift ]; then cat /var/lib/ntp/drift; else echo 0; fi

UserParameter=time.offset[*],ntpdate -p 1 -q $1 | grep -oP '(?<=offset ).*?(?= sec)'

UserParameter=time.running,ps aux | grep ntp | grep -v grep | wc -l
```
```
# vim /etc/zabbix/zabbix_agentd.conf
UnsafeUserParameters=0
```

3. Restart zabbix agent
```
# /etc/init.d/zabbix-agent restart
```


