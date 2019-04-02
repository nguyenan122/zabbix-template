CHECK MULTI PORT ZABBIX.

(tải scripts + file check : "check_multi_port_v2.zip")

#1. Sửa file zabbix_agent.conf (setting timeout = 30s)

vim /etc/zabbix/zabbix_agentd.conf


- Tăng thời gian timeout:

Timeout=30

- Thêm 1 dòng config để gọi check_multi_port.sh:

UserParameter=check_multi_port,/etc/zabbix/scripts/check_multi_port.sh

- Khởi động lại zabbix_agent:

/etc/init.d/zabbix-agent restart



#2. Copy scripts.

mkdir /etc/zabbix/scripts



Copy 2 file check_multi_port.sh và check_tcp vào thư mục vừa tạo /etc/zabbix/scripts

chmod +x /etc/zabbix/scripts/check_multi_port.sh

chmod +x /etc/zabbix/scripts/check_tcp



#Sửa file check_multi_port.sh. Điền những IP và Port cần check. Theo dạng sau:

list_port="127.0.0.1;8881;Loi_Connect_toi_OSC1

localhost;8882;Loi_Connect_toi_OSC2

localhost;8883;Loi_Connect_toi_OSC3

10.144.19.131;8888;Loi_Connect_toi_OSC4" 



##Giải thích:

127.0.0.1;8881;Loi_Connect_toi_OSC1

Mỗi dòng là 1 IP và 1 Port, kèm theo cuối cùng là chữ sẽ bắn lên zabbix. Cách nhau bởi dấu chấm phẩy ;

Chú ý: “Loi_Connect_toi_OSC4” phải viết liền, không được dùng dấu cách, nếu cần thì có thể sử dụng gạch ngang _ hoặc – để nối.



#TEST

[root@cspmanager01 scripts]# ./check_multi_port_v2.sh 

Loi_Connect_toi_OSC2 ip_localhost:8888

Loi_Connect_toi_OSC3 ip_localhost:8888

Loi_Connect_toi_OSC4 ip_10.144.19.131:8888



#Change quyền về zabbix:

chown zabbix:zabbix /tmp/check_multi_port.log*

chmod 664 /tmp/check_multi_port.log*

