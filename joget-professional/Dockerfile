# jogetworkflow/joget-professional
FROM jogetworkflow/ubuntu-openjdk-mysql:16.04

# set environment variables
ENV JOGET_VERSION joget-professional-linux-6.0.1
ENV JOGET_VIRTUALHOST false
ENV ASPECTJ_VERSION aspectjweaver-1.6.12
ENV WFLOW_HOME /opt/joget/wflow/
ENV MYSQL_HOST localhost
ENV MYSQL_PORT 3306
ENV MYSQL_DATABASE jwdb
ENV MYSQL_USER root
ENV MYSQL_PASSWORD ""

# Create an app user so our program doesn't run as root.
RUN groupadd -r app &&\
    useradd -r -g app -d /home/app -c "Docker image user" app \
    ; echo "app:app" | chpasswd \
    ; usermod -aG sudo app \
    ; echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# set java opts
 ENV JAVA_OPTS -Xmx1024m -XX:MaxPermSize=256m -Dwflow.home=${WFLOW_HOME}

# copy installer and scripts
COPY ${JOGET_VERSION}.tar.gz /opt/joget/
COPY run.sh /opt/joget/

# copy files
RUN \
cd /opt/joget/ \
; tar xvfz ${JOGET_VERSION}.tar.gz \
; cd ${JOGET_VERSION}/ \
; mv *.* /opt/joget/ \
; mv * /opt/joget/ \
; rm -rf /opt/joget/${JOGET_VERSION}/ \
; rm /opt/joget/${JOGET_VERSION}.tar.gz

# Chown all the files to the app user.
RUN chown -R app:app /opt/joget

# Change to the app user.
USER app

# make script executable
RUN chmod +x /opt/joget/run.sh

# Command to run
ENTRYPOINT ["/opt/joget/run.sh"]
CMD [""]
