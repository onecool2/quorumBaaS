# Pull Geth into a second stage deploy alpine container
FROM centos:latest
#FROM alpine:latest

#RUN apk add --no-cache ca-certificates
COPY ./build/bin/* /usr/local/bin/
COPY faucet.sh /usr/local/bin/faucet.sh
CMD faucet.sh
#ENTRYPOINT ["geth.sh"]
