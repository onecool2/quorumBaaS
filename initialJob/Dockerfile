# Pull Geth into a second stage deploy alpine container
#FROM openjdk:8-jre-alpine
FROM centos:latest
RUN yum install java-1.8.0-openjdk.x86_64 -y
COPY ./generateNodes.sh /usr/local/bin/generateNodes.sh
COPY ./build/bin/geth /usr/local/bin/geth
COPY ./build/bin/puppeth /usr/local/bin/puppeth
COPY ./build/bin/bootnode /usr/local/bin/bootnode
COPY ./build/bin/tessera-app-0.7.3-app.jar /usr/local/bin/tessera-app-0.7.3-app.jar
COPY ./conf/* /etc/
CMD generateNodes.sh
