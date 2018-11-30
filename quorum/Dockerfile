# Pull Geth into a second stage deploy alpine container
FROM centos:latest
#FROM alpine:latest

#RUN apk add --no-cache ca-certificates
COPY ./build/bin/* /usr/local/bin/

COPY geth.sh /usr/local/bin/geth.sh
EXPOSE 8545 8546 30303 30303/udp
CMD geth.sh
#ENTRYPOINT ["geth.sh"]
