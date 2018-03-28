#!/bin/bash

if [[ "$MYSQL_HOST" == "localhost" ]]; then
    # start mysql
    sudo service mysql start

    # create database
    if [[ "$MYSQL_PASSWORD" == "" ]]; then
        mysql -u${MYSQL_USER} -e "create database ${MYSQL_DATABASE}"
    else
        mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e "create database ${MYSQL_DATABASE}"
    fi
fi

# setup database
cd /opt/joget/
./apache-ant-1.7.1/bin/ant setup -Ddb.host=${MYSQL_HOST} -Ddb.port=${MYSQL_PORT} -Ddb.user=${MYSQL_USER} -Ddb.password=${MYSQL_PASSWORD} -Ddb.name=${MYSQL_DATABASE} -Dprofile.name=default

# start tomcat
./apache-tomcat-8.0.20/bin/catalina.sh run

