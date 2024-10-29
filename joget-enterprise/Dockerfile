# start build image
FROM eclipse-temurin:21 AS build

# set build environment variables
ENV JOGET_VERSION joget-enterprise-linux-9.0-SNAPSHOT

# copy installers
ADD ${JOGET_VERSION}.tar.gz /opt/

# unzip war, move files and delete unused files
RUN mv /opt/${JOGET_VERSION} /opt/joget && \
    mv /opt/joget/apache-tomcat-* /opt/joget/apache-tomcat && \
    rm -r /opt/joget/apache-tomcat/webapps/docs && \
    rm -r /opt/joget/apache-tomcat/webapps/examples && \
    rm -r /opt/joget/apache-tomcat/webapps/host-manager && \
    rm -r /opt/joget/apache-tomcat/webapps/manager && \
    mkdir /opt/joget/apache-tomcat/webapps/jw && cd /opt/joget/apache-tomcat/webapps/jw && \
    jar -xvf /opt/joget/apache-tomcat/webapps/jw.war && \
    rm /opt/joget/apache-tomcat/webapps/jw.war && \
    mkdir /opt/joget/lib && \
    mv /opt/joget/wflow/aspectjweaver* /opt/joget/lib/ && \
    mv /opt/joget/wflow/glowroot /opt/joget/lib/

# copy custom files
COPY joget /opt/joget/

# add user, group and permissions
RUN groupadd tomcat && useradd tomcat -g tomcat \
    && chmod -R "ug+rwx" /opt/joget \
    && chown -R tomcat:root /opt/joget \
    && chmod +x /opt/joget/run.sh

# start runtime image
FROM eclipse-temurin:21

# set environment variables
ENV ASPECTJ_VERSION aspectjweaver-1.9.22
ENV LIB_HOME /opt/joget/lib
ENV WFLOW_HOME /opt/joget/wflow
ENV WFLOW_IGNITE true
ENV WFLOW_IGNITE_JDBC true
ENV WFLOW_ASYNC_TIMEOUT 2000
ENV MYSQL_HOST localhost
ENV MYSQL_PORT 3306
ENV MYSQL_DATABASE jwdb
ENV MYSQL_USER root
ENV MYSQL_PASSWORD root

# set java opts
ENV JAVA_OPTS -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=70 -Dwflow.home=${WFLOW_HOME} -Dwflow.ignite=${WFLOW_IGNITE} -Dwflow.igniteJdbc=${WFLOW_IGNITE_JDBC} -Dwflow.asyncRequestTimeout=${WFLOW_ASYNC_TIMEOUT} --add-opens=java.base/java.nio=ALL-UNNAMED -javaagent:${LIB_HOME}/${ASPECTJ_VERSION}.jar -javaagent:${LIB_HOME}/glowroot/glowroot.jar

# add user & group, and permissions necessary to permit running with a randomised UID
# install security updates, mysql-client and vim
RUN groupadd tomcat && useradd tomcat -g tomcat \
    && chmod 664 /etc/passwd \
    && apt update && apt-get -s dist-upgrade | grep "^Inst" | grep -i securi | awk -F " " {'print $2'} | xargs apt-get install \
    && apt install --no-install-recommends -y mysql-client vim-tiny  \
    && apt clean && rm -rf /var/lib/apt/lists/*

# copy joget directory
COPY --from=build /opt/joget /opt/joget

# switch to Tomcat user
USER tomcat

# define storage volume
VOLUME /opt/joget/wflow

# expose ports
EXPOSE 8080
EXPOSE 9090
EXPOSE 4000

# Command to run
ENTRYPOINT ["/opt/joget/run.sh"]
CMD [""]
