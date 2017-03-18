#!/bin/bash

function shutdown()
{
    date
    export TOMCAT_HOME=/opt/tomcat
    echo "Shutting down Tomcat"
    unset CATALINA_PID # Necessary in some cases
    unset LD_LIBRARY_PATH # Necessary in some cases
    unset JAVA_OPTS # Necessary in some cases

    $TOMCAT_HOME/bin/catalina.sh stop
}

date
echo "Starting Tomcat"
export CATALINA_PID=/tmp/$$
export JAVA_HOME=/opt/java
export TOMCAT_HOME=/opt/tomcat


#tomcat change port to 7080
sed -i 's/<Connector port="8080"/<Connector port="7080"/'  $TOMCAT_HOME/conf/server.xml

. $TOMCAT_HOME/bin/catalina.sh start

# Allow any signal which would kill a process to stop Tomcat
trap shutdown HUP INT QUIT ABRT KILL ALRM TERM TSTP

echo "Waiting for `cat $CATALINA_PID`"
wait `cat $CATALINA_PID`



