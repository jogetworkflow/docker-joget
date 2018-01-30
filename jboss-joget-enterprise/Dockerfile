# jogetworkflow/jboss-joget-enterprise
FROM jboss/wildfly

# set environment variables
ENV JOGET_VERSION joget-enterprise-linux-6.0.1
ENV WFLOW_HOME /opt/joget/wflow/
ENV MYSQL_HOST localhost
ENV MYSQL_PORT 3306
ENV MYSQL_DATABASE jwdb
ENV MYSQL_USER root
ENV MYSQL_PASSWORD ""

# User root user to install software
USER root

# Install necessary packages
ADD mysql57-community-release-el7-11.noarch.rpm /root/
RUN rpm -ivh /root/mysql57-community-release-el7-11.noarch.rpm \
; yum -y install mysql \
; yum clean all

# copy installer and scripts
COPY ${JOGET_VERSION}.tar.gz /opt/joget/

# copy files
RUN \
cd /opt/joget/ \
; tar xvfz ${JOGET_VERSION}.tar.gz \
; cd ${JOGET_VERSION}/ \
; mv *.* /opt/joget/ \
; mv * /opt/joget/ \
; rm -rf /opt/joget/${JOGET_VERSION}/ \
; rm /opt/joget/${JOGET_VERSION}.tar.gz \
; cp /opt/joget/apache-tomcat-*/webapps/jw.war /opt/jboss/wildfly/standalone/deployments/ \
; rm -rf /opt/joget/apache-tomcat-*

# copy script
COPY run.sh /opt/joget/

# Chown all the files to the jboss user.
RUN chmod +x /opt/joget/run.sh && \
    chown -R jboss:0 /opt/joget && \
    chmod -R g+rw /opt/joget

# Switch back to jboss user
USER jboss

# Command to run
ENTRYPOINT ["/opt/joget/run.sh"]
CMD [""]


