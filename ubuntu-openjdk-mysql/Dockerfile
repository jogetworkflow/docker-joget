# jogetworkflow/ubuntu-openjdk-mysql
FROM ubuntu:18.04

# install openjdk
RUN apt-get update && apt-get install -y sudo
RUN apt-get install -y openjdk-11-jre

# install mysql
RUN echo "mysql-server-5.7 mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server-5.7 mysql-server/root_password_again password root" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server-5.7
RUN find /var/lib/mysql -type f -exec touch {} \; && service mysql start

CMD ["bash"]

