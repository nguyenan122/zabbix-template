1. Tải + Copy scripts "check_multi_services.sh" lên thư mục /etc/zabbix/scripts của server

2. Thay đổi tham số theo services cần check.
list="1;CrossSale_SMPP_v2.jar;1
2;apache-tomcat-8.0.47;crosssale;1
2;redis-server;6379;1" 

Giải thích

1 dòng chia ra các trường

A - B - C hoặc

A - B - C - D

Nếu A = 3 thì ps aux | grep B | grep -v grep | wc -l > sau đó so sánh với C

Nếu A = 4 thì ps aux | grep B | grep -v grep | grep C | wc -l > sau đó so sánh với D

3. Test thử + Phân lại quyền

/etc/zabbix/scripts/check_multi_services.sh

chown zabbix:zabbix /tmp/count_tmp.log

4. Sửa config zabbix agent

vim /etc/zabbix/zabbix_agentd.d/userparameter_services.conf
UserParameter=check_multi_port,/etc/zabbix/scripts/check_multi_port.sh
UserParameter=check_multi_services,/etc/zabbix/scripts/check_multi_services.sh
/etc/init.d/zabbix-agent restart
