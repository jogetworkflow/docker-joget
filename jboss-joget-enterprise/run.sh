#!/bin/bash

# setup database
cd /opt/joget/
./apache-ant-1.7.1/bin/ant setup -Ddb.host=${MYSQL_HOST} -Ddb.port=${MYSQL_PORT} -Ddb.user=${MYSQL_USER} -Ddb.password=${MYSQL_PASSWORD} -Ddb.name=${MYSQL_DATABASE} -Dprofile.name=default

# start jboss
export JAVA_OPTS="$JAVA_OPTS-Djava.net.preferIPv4Stack=true -Dwflow.home=/opt/joget/wflow"
/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0
