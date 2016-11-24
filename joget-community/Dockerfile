# jogetworkflow/joget-community
FROM tomcat:8

# set environment variables
ENV JOGET_VERSION joget-linux-5.0.9
ENV JOGET_VIRTUALHOST false
ENV INSTALLER_PATH ./
ENV ASPECTJ_VERSION aspectjweaver-1.6.12
ENV WFLOW_HOME /opt/joget/wflow/
ENV MYSQL_HOST localhost
ENV MYSQL_PORT 3306
ENV MYSQL_DATABASE jwdb
ENV MYSQL_USER root
ENV MYSQL_PASSWORD ""

# set java opts
 ENV JAVA_OPTS -Xmx1024m -XX:MaxPermSize=256m -Dwflow.home=${WFLOW_HOME}

# copy installer and scripts
COPY ${INSTALLER_PATH}${JOGET_VERSION}.tar.gz /opt/joget/
COPY run.sh /opt/joget/

# install mysql
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

# copy files
RUN \
cd /opt/joget/ \
; tar xvfz ${JOGET_VERSION}.tar.gz \
; cd ${JOGET_VERSION}/ \
; find . -name 'jw*.war' -exec mv -t /usr/local/tomcat/webapps/ {} + \
; rm -rf apache-tomcat-* \
; mv *.* /opt/joget/ \
; mv * /opt/joget/ \
; rm -rf /opt/joget/${JOGET_VERSION}/ \
; rm /opt/joget/${JOGET_VERSION}.tar.gz

# replace tomcat server.xml
COPY server.xml /usr/local/tomcat/conf/server.xml

# make script executable
RUN chmod +x /opt/joget/run.sh

# Command to run
ENTRYPOINT ["/opt/joget/run.sh"]
CMD [""]
