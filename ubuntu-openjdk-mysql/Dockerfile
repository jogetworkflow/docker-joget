# jogetworkflow/ubuntu-openjdk-mysql
FROM ubuntu:16.04

# install openjdk
RUN apt-get update && apt-get install -y sudo
RUN apt-get install -y openjdk-8-jre

# install mysql
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
RUN find /var/lib/mysql -type f -exec touch {} \; && service mysql start

CMD ["bash"]

