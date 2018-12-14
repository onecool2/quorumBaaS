FROM centos:latest
COPY mongodb-org-server-3.6.9-1.el7.x86_64.rpm /tmp
RUN yum install -y openssl && rpm -ihv /tmp/mongodb-org-server-3.6.9-1.el7.x86_64.rpm
COPY mongod.conf /etc/mongod.conf
CMD mongod -f /etc/mongod.conf && tail -f /var/log/mongodb/mongod.log
