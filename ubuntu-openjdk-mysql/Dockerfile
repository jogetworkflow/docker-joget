# jogetworkflow/ubuntu-openjdk-mysql
FROM ubuntu:20.04

# install security updates
RUN apt update && apt-get -s dist-upgrade | grep "^Inst" | grep -i securi | awk -F " " {'print $2'} | xargs apt-get install

# install java
RUN apt install --no-install-recommends -y openjdk-11-jre-headless

# install mysql
# change mysql authentication plugin to mysql_native_password
# added chmod 755 fix for mysql incorrect 0700 file permission bug blocking non-root user connection over the socket
RUN DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends -y mysql-server-8.0 \
  && service mysql start \
  && chmod 755 /var/run/mysqld \ 
  && mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root'"

# install sudo and vim
RUN apt install --no-install-recommends -y sudo vim-tiny

# cleanup
RUN apt clean && rm -rf /var/lib/apt/lists/*

# add user & group, and permissions necessary to permit running with a randomised UID
RUN groupadd tomcat && useradd tomcat -g tomcat \
    && echo "tomcat:tomcat" | chpasswd \
    && usermod -aG 0 tomcat \
    && usermod -aG sudo tomcat \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && chmod 664 /etc/passwd

CMD ["bash"]
