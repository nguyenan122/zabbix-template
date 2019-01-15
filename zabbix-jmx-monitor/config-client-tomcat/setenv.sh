#Set Heap Memory Commnit and Max
export CATALINA_OPTS="$CATALINA_OPTS -Xms1024m"
export CATALINA_OPTS="$CATALINA_OPTS -Xmx3096m"

#Enable JMX with no authenticaion
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote \
 -Dcom.sun.management.jmxremote.port=12345 \
 -Dcom.sun.management.jmxremote.authenticate=true \
 -Dcom.sun.management.jmxremote.password.file=/opt/tomcat/conf/jmxremote.password \
 -Dcom.sun.management.jmxremote.access.file=/opt/tomcat/conf/jmxremote.access \
 -Dcom.sun.management.jmxremote.ssl=false \
 -Djava.rmi.server.hostname=192.168.80.134"
