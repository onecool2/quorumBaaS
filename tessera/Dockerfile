# Create docker image with only distribution jar
FROM openjdk:8-jre-alpine

COPY tessera-app/target/tessera-app-0.7.3-app.jar /tessera/tessera-app.jar
RUN mkdir -p /tesserasocket
COPY tessera.sh /usr/local/bin

CMD /usr/local/bin/tessera.sh
#ENTRYPOINT ["java", "-jar", "/tessera/tessera-app.jar"]
