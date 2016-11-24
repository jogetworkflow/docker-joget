# jogetworkflow/joget-enterprise
FROM jogetworkflow/joget-community

# set environment variables
ENV JOGET_VERSION joget-enterprise-linux-5.0.9
ENV JOGET_VIRTUALHOST false
ENV INSTALLER_PATH ./
ENV ASPECTJ_VERSION aspectjweaver-1.8.5
ENV WFLOW_HOME /opt/joget/wflow/
ENV MYSQL_HOST localhost
ENV MYSQL_PORT 3306
ENV MYSQL_DATABASE jwdb
ENV MYSQL_USER root
ENV MYSQL_PASSWORD ""

# set java opts for v4
#ENV JAVA_OPTS -Xmx1024m -XX:MaxPermSize=256m -Dwflow.home=${WFLOW_HOME}

# set java opts for v5 or cloud
ENV JAVA_OPTS -Xmx1024m -XX:MaxPermSize=256m -Dwflow.home=${WFLOW_HOME} -Dwflow.virtualhost=${JOGET_VIRTUALHOST} -javaagent:/opt/joget/lib/${ASPECTJ_VERSION}.jar

# copy installer and scripts
COPY ${INSTALLER_PATH}${JOGET_VERSION}.tar.gz /opt/joget/

# copy files
RUN \
cd /opt/joget/ \
; tar xvfz ${JOGET_VERSION}.tar.gz \
; cd ${JOGET_VERSION}/ \
; find . -name 'jw*.war' -exec mv -t /usr/local/tomcat/webapps/ {} + \
; rm -rf apache-tomcat-* \
; cp -r *.* /opt/joget/ \
; cp -r * /opt/joget/ \
; mkdir -p /opt/joget/lib \
; cp /opt/joget/wflow/${ASPECTJ_VERSION}.jar /opt/joget/lib \
; rm -rf /opt/joget/${JOGET_VERSION}/ \
; rm /opt/joget/${JOGET_VERSION}.tar.gz

# replace tomcat server.xml
COPY server.xml /usr/local/tomcat/conf/server.xml

# Command to run
ENTRYPOINT ["/opt/joget/run.sh"]
CMD [""]
